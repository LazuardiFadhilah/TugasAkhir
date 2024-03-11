const { Category } = require("../models");
const sequelize = require("sequelize");
const Op = sequelize.Op;
const { paginate } = require("../utilites/pagination.js");

class CatogeryController {
  async store(req, res) {
    try {
      const { title } = req.body;
      if (!title) {
        return res.status(400).json({ message: "Title is required" });
      }
      const isExist = await Category.findOne({ where: { title } });
      if (isExist) {
        return res.status(400).json({ message: "Title is already exist" });
      }
      const category = await Category.create({ title });
      return res.json({
        code: 201,
        message: "Data berhasil dibuat",
        data: category,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

  async show(req, res) {
    try {
      const limit = req.query.limit ?? 5;
      const title = req.query.title ?? "";
      const page = req.query.page ?? 1;

      // console.log(limit);

      const category = await Category.findAll(
        paginate(
          {
            where: { title: { [Op.like]: "%" + title + "%" } },
          },
          {
            page: parseInt(page),
            pageSize: parseInt(limit),
          }
        )
      );

      return res.json({
        code: 200,
        message: `${category.length} data sudah diterima`,
        count: category.length,
        data: category,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

  async showId(req, res) {
    try {
      const { id } = req.params;

      const category = await Category.findOne({
        where: {
          id: id,
        },
      });
      console.log(category);
      return res.json({
        code: 200,
        message: `Data sudah diterima`,
        data: category,
      });
    } catch (error) {
      return res.status(404).json({ message: "Data Not Found" });
    }
  }
  async update(req, res) {
    try {
      const { id } = req.params;
      const { title } = req.body;
      const isExist = await Category.findOne({ where: { id } });
      if(isExist == null){
        return res.status(404).json({ message: "Data Not Found" });
      }
      if (!title) {
        return res.status(400).json({ message: "Title is required" });
      }
      const category = await Category.update(
        { title },
        {
          where: {
            id: id,
          },
        }
      );
      return res.json({
        code: 200,
        message: `Data berhasil diperbaharui`,
        data: isExist,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

  async destroy(req,res){
    try {
        const {id} = req.params;
        console.log(id);
        const category = await Category.destroy({where:{id:id}});
        return res.json({
            "code": 200,
            "message": `Data berhasil dihapus`,
        });
        
    } catch (error) {
        return res.status(400).json({message:error.message});
    }
}
}

module.exports = new CatogeryController();
