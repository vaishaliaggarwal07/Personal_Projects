const mongoose = require("mongoose");
const slugify = require("slugify");
const {appendSASToBanner} = require("../service/azureService");
// const validator = require('validator');

const movieSchema = new mongoose.Schema(
    {
        title: {
            type: String,
        },
        brandTitle: {
            type: String,
        },
        duration: {
            type: String,
        },
        categories: {
            type: Array,
        },
        subtitles: [
            {
                type: Array,
                url: String,
            },
        ],
        movieSubtitles: [
            {
                language: {
                    type: String,
                },
                subtitle: {
                    type: String,
                },
            },
        ],
        subtitlesLan: [
            {
                type: Array,
            },
        ],
        banners: {
            type: Array,
        },
        languages: {
            type: Array,
        },
        dhaakadRating: {
            type: String,
        },
        ageGroup: {
            type: Array,
        },
        casts: {
            type: Array,
        },
        price: {
            type: Number,
        },
        offerPrice: {
            type: Number,
        },
        description: {
            type: String,
            $regex:
                "^([A-Za-z0-9_-.])+@$||/+=-*+(){}[]!%&~:;><₹`'weweRRER2323“Dar’'\n\f1960s Lorem Ipsum Oxford'",
        },
        subDescription: {
            type: String,
        },
        toolTip: {
            type: String,
        },
        releaseYear: {
            type: Number,
        },
        slug: String,
        isFeatured: Boolean,
        isTrend: Boolean,
        movieUrl: Array,
        trailerUrl: Array,
        totalReviewsCount: {
            type: Number,
            default: 0,
        },
        createdAt: {
            type: Date,
            default: Date.now(),
        },
        updatedAt: {
            type: Date,
            default: Date.now,
        },
        releaseDate: Date,
        expireDate: Date,
        status: {
            type: String,
            default: "Active",
        },
        castIds: {
            type: Array,
            default: [],
        },
        averageRating: {
            type: Number,
            min: 1,
            max: 5,
        },
        streamed: {
            type: Boolean,
            default: false,
        },
        encodingStatus: {
            type: String,
            default: 'In-Progress'
        },
        movieUploadedUrl:{
            type:String
        },
        trailerUploadedUrl:{
            type:String
        },
        azureTrailerEncodingDetails:{
            encodingStatus:{
                type:String
            },
            locatorName:{
                type:String
            },
            outputAssetName:{
                type:String
            },
            jobName:{
                type:String
            },
            encodingTransformName:{
                type:String
            },
            streamingEndPointHostName:{
                type:String
            }
        },
        azureMovieEncodingDetails:{
            encodingStatus:{
                type:String
            },
            locatorName:{
                type:String
            },
            outputAssetName:{
                type:String
            },
            jobName:{
                type:String
            },
            encodingTransformName:{
                type:String
            },
            streamingEndPointHostName:{
                type:String
            }
        },


    },
    {
        toJSON: {virtuals: true},
        toObject: {virtuals: true},
    }
);

// movieSchema.virtual("durationWeeks").get(function () {
//   return this.duration / 7;
// });

// DOCUMENT MIDDLEWARE: runs before .save() and .create()
movieSchema.pre("save", function (next) {
    this.updatedAt = Date.now();
    this.slug = slugify(this.title, {lower: true});
    next();
});

// movieSchema.pre('save', function(next) {
//   console.log('Will save document...');
//   next();
// });

// movieSchema.post('save', function(doc, next) {
//   console.log(doc);
//   next();
// });

// QUERY MIDDLEWARE
// movieSchema.pre('find', function(next) {

movieSchema.pre(/^find/, function (next) {
    this.find({secretMovie: {$ne: true}});

    this.start = Date.now();
    next();
});

movieSchema.pre(/^save/,function (next){
    let newBannerList = [];
    for(let banner of this.banners){
        if(banner.includes('?')){
            newBannerList.push(banner.split('?')[0])
        }else{
            newBannerList.push(banner)
        }
    }
    this.banners = newBannerList;
    next();
})

movieSchema.post(/^find/, function (recordList, next) {
    if(recordList){
        if(recordList.length>0){
            for(let record of recordList){
                if(record){
                    appendSASToBanner(record);
                }
            }
        }else{
            appendSASToBanner(recordList);
        }
    }

    next();
});

// AGGREGATION MIDDLEWARE
movieSchema.pre("aggregate", function (next) {
    this.pipeline().unshift({$match: {secretMovie: {$ne: true}}});

    console.log(this.pipeline());
    next();
});

const Movie = mongoose.model("Movie", movieSchema);

module.exports = Movie;
