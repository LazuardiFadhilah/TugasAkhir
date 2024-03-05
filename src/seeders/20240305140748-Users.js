'use strict';
const bcrypt = require('bcrypt');
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

    await queryInterface.bulkInsert('Users', [{
      id: uuidv4(),
      fullName: 'Lazuardi Fadhilah',
      email: 'Ardi@email.com',
      role: 'Super Admin',
      password: bcrypt.hashSync('password', 10),
      createdAt: new Date(),
      updatedAt:new Date(),
    },{
      id: uuidv4(),
      fullName: 'Andikha Dian',
      email: 'Andikha@email.com',
      role: 'Super Admin',
      password: bcrypt.hashSync('password', 10),
      createdAt: new Date(),
      updatedAt:new Date(),
    },{
      id: uuidv4(),
      fullName: 'Galih Baskoro',
      email: 'Galih@email.com',
      role: 'Super Admin',
      password: bcrypt.hashSync('password', 10),
      createdAt: new Date(),
      updatedAt:new Date(),
      deletedAt:new Date(),
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
