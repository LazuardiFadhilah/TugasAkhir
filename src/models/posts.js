'use strict';
const {DataTypes} = require('sequelize');

const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Posts extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Posts.init({
    
    id:{
      allowNull: false,
      primaryKey: true,
      defaultValue: DataTypes.UUIDV4,
      type: DataTypes.UUID
    },
    title: DataTypes.STRING,
    description: DataTypes.TEXT,
    thumbnail: DataTypes.STRING,
    status: DataTypes.ENUM('Draft', 'Published'),
    slug: DataTypes.STRING,
  },{
    sequelize,
    paranoid:true,
    modelName: 'Posts',
  },
  );
  return Posts;
};