'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Posts', {
      id: {
        allowNull: false,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
        type: Sequelize.UUID
      },
      title: {
        allowNull:false,
        type: Sequelize.STRING
      },
      description: {
        type: Sequelize.TEXT
      },
      thumbnail: {
        type: Sequelize.STRING
      },
      status: {
        defaultValue: 'Draft',
        type: Sequelize.ENUM('Draft', 'Published')
      },
      slug: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      deletedAt:{
        allowNull:true,
        type: Sequelize.DATE
      }}
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Posts');
  }
};