'use strict';
const {DataTypes} = require('sequelize');


const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Users extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    Users.belongsTo(models.Files, {
      foreignKey: 'avatar',
      as: 'Avatar',
    })
    }
  }
  Users.init({
    id: {
      allowNull: false,
      primaryKey: true,
      defaultValue: DataTypes.UUIDV4,
      type: DataTypes.UUID
    },
    fullName: DataTypes.STRING,
    email: DataTypes.STRING,
    role: DataTypes.ENUM('Super Admin', 'Creator'),
    password: DataTypes.STRING,
    status: DataTypes.ENUM('Active', 'Suspend'),
    avatar: DataTypes.STRING
  }, {
    sequelize,
    paranoid:true,
    modelName: 'Users',
    
  });
  return Users;
};
