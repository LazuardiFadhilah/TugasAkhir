'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class postcategories extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      postcategories.belongsTo(models.Posts,{
        foreignKey:'postId',
        // as:'PostCategories',
      });
      postcategories.belongsTo(models.Category,{
        foreignKey: "categoryId",
        // as:"Categories",
      });
    }
  }
  postcategories.init({
    id: {
      allowNull: false,
      primaryKey: true,
      defaultValue: DataTypes.UUIDV4,
      type: DataTypes.UUID
    },
    postId: DataTypes.STRING,
    categoryId: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'postcategories',
  });
  return postcategories;
};