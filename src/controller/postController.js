const { Posts } = require("../models");
const sequelize = require("sequelize");
const Op = sequelize.Op;
const slugify = require("slugify");

class PostController {
  async getSlug(req, res) {
    try {
      const { slug } = req.params;
      const post = await Posts.findAll({
        where: { slug: { [Op.like]: "%" + slug + "%" } },
      });

      console.log(post);
      return res.json({
        code: 200,
        message: `Data sudah diterima`,
        data: post,
      });
    } catch (error) {
      return res.status(404).json({ message: "Data Not Found" });
    }
  }

  async getId(req, res) {
    try {
      const { id } = req.params;
      const post = await Posts.findAll({
        where: { id:id },
      });

      console.log(post);
      return res.json({
        code: 200,
        message: `Data sudah diterima`,
        data: post,
      });
    } catch (error) {
      return res.status(404).json({ message: "Data Not Found" });
    }
  }

  async store(req, res) {
    try {
      const { title, description, status } = req.body;

      // check title description and status if null
      if (!title || !description || !status) {
        return res
          .status(400)
          .json({ message: "Title, Description and status is required" });
      }

      // check status if not Draft or Published
      if (status !== "Draft" && status !== "Published") {
        return res
          .status(400)
          .json({ message: "Status must be Draft or Published" });
      }

      const slug = slugify(title, {
        replacement: "-",
        lower: true,
        strict: true,
      });

      console.log(title, description, status, slug);

      const isExist = await Posts.findOne({ where: { slug: slug } });
      if (isExist) {
        return res.status(400).json({ message: "Title is already exist" });
      }

      const post = await Posts.create({ title, description, status, slug });

      return res.json({
        code: 201,
        message: "Data berhasil dibuat",
        data: post,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

  async destroy(req,res){
    try {
      const { id } = req.params;
      const user = await Posts.destroy({ where: { id: id } });
      return res.json({
        code: 200,
        message: `Data berhasil dihapus`,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

}

module.exports = new PostController();
