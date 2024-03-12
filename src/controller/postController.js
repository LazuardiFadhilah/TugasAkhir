const { Posts } = require("../models");
const sequelize = require("sequelize");
const Op = sequelize.Op;
const slugify = require("slugify");

class PostController {
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
}

module.exports = new PostController();
