const express = require('express');
const languageController = require('./../controllers/languageController');
const authController = require('./../controllers/authController');

const router = express.Router({ mergeParams: true });

// router.use(authController.protect);

router
  .route('/')
  .get(languageController.getAllLanguages)
  .post(authController.protect, languageController.createLanguage);

router
  .route('/:id')
  .get(languageController.getLanguage)
  .patch(
    authController.protect, languageController.updateLanguage
  )
  .delete(
    authController.protect, languageController.deleteLanguage
  );

module.exports = router;
