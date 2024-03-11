'use strict';
const { v4: uuidv4 } = require('uuid');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */
   await queryInterface.bulkInsert('Categories', [{
    
    id: uuidv4(),
    title: 'Technology',
    createdAt: new Date(),
    updatedAt: new Date()
   },{
    id: uuidv4(),
    title: 'Backend',
    createdAt: new Date(),
    updatedAt: new Date()
   },{
    id: uuidv4(),
    title: 'FrontEnd',
    createdAt: new Date(),
    updatedAt: new Date()
   }]);
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
