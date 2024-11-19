const express = require("express");
const movieController = require("../controllers/movieController");
const authController = require("../controllers/authController");

const router = express.Router();

// router.param('id', movieController.checkID);

router.route("/top-5-cheap").get(movieController.aliasTopMovies, movieController.getAllMovies);

router.route("/top-trending").get(movieController.aliasTopMovies, movieController.getTrendMovies);

router.route("/coming-movies").get(movieController.aliasTopMovies, movieController.getComingMovies);

router.route("/stream-movies").get(movieController.aliasTopMovies, movieController.getStreamMovies);

router.route("/recent-movies").get(movieController.aliasTopMovies, movieController.getRecentlyAdded);

router.route("/movie-stats").get(movieController.getMovieStats);
router.route("/monthly-plan/:year").get(movieController.getMonthlyPlan);
router.patch("/addSubtitleToMovie/:id", movieController.addSubtitleToMovie);
router.patch("/deleteSubtitleToMovie/:id", movieController.deleteSubtitleToMovie);
router.patch("/updateSubtitleToMovie/:id", movieController.updateSubtitleToMovie);

router.route("/purches-movies/:userid").get(movieController.aliasTopMovies, movieController.getPurcheMovies);

// router.route("/uploadSubtitlesS3").post(movieController.uploadSubtitlesS3);
router.post("/uploadSubtitlesS3", movieController.uploadSubtitle, movieController.uploadSubtitlesS3);
router.route("/updateStream/:movieid").patch(movieController.updateStream);

router.route("/getPreBookedMovies/:userid").get(movieController.getPreBookedMovies);
router.route("/getRentMovies/:userid").get(movieController.getRentMovies);
router.route("/getpbookedMovies/:userid").get(movieController.getpbookedMovies);

router.route("/").get(movieController.getAllMovies)
    .post(movieController.uploadMovieImages, /*movieController.resizeMovieImages,*/ movieController.createMovie);

router.route("/:id").get(movieController.getMovie)
    .patch(movieController.uploadMovieImages, /*movieController.updateFiles,*/ movieController.updateMovie)
    .delete(authController.protect, movieController.deleteMovie);

router.post('/upload/token',authController.protect,movieController.createUploadToken);
router.post('/upload/encoding',movieController.createEncoding);
router.patch('/job/:type/:id',movieController.reRunJob);
router.patch('/job/:id',movieController.updateJobStatus)

module.exports = router;
