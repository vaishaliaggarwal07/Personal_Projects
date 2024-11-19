const express = require("express");
const morgan = require("morgan");
const rateLimit = require("express-rate-limit");
const helmet = require("helmet");
const mongoSanitize = require("express-mongo-sanitize");
const xss = require("xss-clean");
const hpp = require("hpp");
const cors = require("cors");
const cookieParser = require("cookie-parser");

const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
const movieRouter = require("./routes/movieRoutes");
const userRouter = require("./routes/userRoutes");
const reviewRouter = require("./routes/reviewRoutes");
const categoryRouter = require("./routes/categoryRoutes");
const languageRouter = require("./routes/languageRoutes");
const rewardRouter = require("./routes/rewardRoutes");
const castRouter = require("./routes/castRoutes");
const userMovieRouter = require("./routes/userMoviesRoute");
const { expressjwt: jwt } = require("express-jwt");
const notificationsRoutes = require("./routes/notificationRoutes");
const movieTrasncations = require("./routes/movieTrasncationsRoute");
const suportRoutes = require("./routes/suportRoute");
const purchaseRoutes = require("./routes/purchaseRoutes");
const joinUsRoutes = require("./routes/joinUsRoutes")
const currentUserMovieRoute = require("./routes/currentUserMovieRoute");
const mongoose = require("mongoose");

const swaggerUi = require('swagger-ui-express');
const fs = require("fs");
const YAML = require('yaml');
const file  = fs.readFileSync('./docs/api_docs.yaml', 'utf8');
const swaggerDocument = YAML.parse(file)

const app = express();
mongoose.set("strictQuery", false);

app.use(express.json({ limit: "10mb" }));
// 1) GLOBAL MIDDLEWARES
// Set security HTTP headers
app.use(helmet());

// Development logging
app.use(morgan("dev"));

// swagger doc
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

const whitelist = [
    'https://dhaakadcinema.com',
    'https://www.dhaakadcinema.com',
    'https://admin.dhaakadcinema.com',
    'http://localhost:3000',
    'http://localhost:4000',
    'http://dhaakadmobile',
]
// const corsOptions = {
//     origin: function (origin, callback) {
//         if (whitelist.indexOf(origin) !== -1) {
//             callback(null, true)
//         } else {
//             callback(new Error('Not allowed by CORS'))
//         }
//     },
//     credentials: true,
//     optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
// }
// app.use(cors(corsOptions));
app.use(cors(
  {
    origin: ["http://localhost:3000"],
    credentials: true,
  }
));
app.options("*",cors());
app.use(function(req, res, next) {
    res.header('Content-Type', 'application/json;charset=UTF-8')
    res.header('Access-Control-Allow-Credentials', true)
    res.header(
        'Access-Control-Allow-Headers',
        'Origin, X-Requested-With, Content-Type, Accept'
    );
    res.header('Access-Control-Allow-Origin',req.headers.origin);
    // res.header('Access-Control-Allow-Methods','GET, POST, PUT, PATCH, DELETE')
    next();
})

app.use(cookieParser());

const whiteListRoute =["/public",'/api/v1/users/token/public',/\/api-docs*/,'/api/v1/users/login']
app.use(async(req,res,next)=>{
    let isFreePass = false
    for(let route of whiteListRoute){
        if(req.url.match(route)){
            isFreePass = true;
            break;
        }
    }
    if(isFreePass){
        next();
    }else{
        if(!(req.headers.authorization &&
            req.headers.authorization.startsWith("Bearer") &&
            req.headers.authorization.split(" ")[1])){
            const publicCookie = req.cookies['public'];
            if(publicCookie){
                req.headers.authorization = 'Bearer '+publicCookie;
                next();
            }else{
                res.status(401).json({statusCode:401,status:'access denied by cookie'});
            }
        }else{
            next();
        }
    }

})

const limiter = rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minutes
  max: 100, // Limit each IP to 100 requests per `window` (here, per 1 minutes)
  standardHeaders: 'draft-7', // draft-6: RateLimit-* headers; draft-7: combined RateLimit header
  legacyHeaders: false, // X-RateLimit-* headers
  // store: ... , // Use an external store for more precise rate limiting
})

// Apply the rate limiting middleware to all requests
app.use(limiter)
// Body parser, reading data from body into req.body
// app.use(express.json({ limit: "10kb" }));

// Data sanitization against NoSQL query injection
app.use(mongoSanitize());

// Data sanitization against XSS
app.use(xss());

// Prevent parameter pollution
app.use(
  hpp({
    whitelist: [
      "duration",
      "ratingsQuantity",
      "ratingsAverage",
      "maxGroupSize",
      "difficulty",
      "price",
    ],
  })
);

app.use(
    jwt({
      secret: process.env.JWT_SECRET,
      algorithms: ["HS256"],
    }).unless({ path: whiteListRoute })
);

// Serving static files
app.use(express.static(`${__dirname}/public`));

// Test middleware
app.use((req, res, next) => {
  req.requestTime = new Date().toISOString();
  // console.log(req.headers);
  next();
});
///

app.use(express.json());

// 3) ROUTES
app.use("/api/v1/movies", movieRouter);
app.use("/api/v1/users", userRouter);
app.use("/api/v1/reviews", reviewRouter);
app.use("/api/v1/categories", categoryRouter);
app.use("/api/v1/languages", languageRouter);
app.use("/api/v1/rewards", rewardRouter);
app.use("/api/v1/casts", castRouter);
app.use("/api/v1/usermovies", userMovieRouter);
app.use("/api/v1/notifications", notificationsRoutes);
app.use("/api/v1/trasncations", movieTrasncations);
app.use("/api/v1/suport", suportRoutes);
app.use("/api/v1/purchase", purchaseRoutes);
app.use("/api/v1/current-user-movie", currentUserMovieRoute);
app.use("/api/v1/joinUs",joinUsRoutes);
app.all("*", (req, res, next) => {
  next(new AppError(`Can't find ${req.originalUrl} on this server!`, 404));
});

app.use(globalErrorHandler);

module.exports = app;
