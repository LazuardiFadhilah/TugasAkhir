'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Category extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      Category.belongsToMany(models.Posts,{
        through: 'postcategories',
        unique:false,
        foreignKey:'categoryId',
        // as:'Categories',
      });
    }
  }
  Category.init({
    id:{
      allowNull: false,
      primaryKey: true,
      defaultValue: DataTypes.UUIDV4,
      type: DataTypes.UUID
    },
    title: DataTypes.STRING
  }, {
    sequelize,
    paranoid:true,
    modelName: 'Category',
  });
  return Category;
};