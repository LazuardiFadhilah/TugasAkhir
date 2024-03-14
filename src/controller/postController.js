const { Posts } = require("../models");
const { Category } = require("../models");
const { postcategories } = require("../models");
const sequelize = require("sequelize");
const Op = sequelize.Op;
const slugify = require("slugify");
const { paginate } = require("../utilites/pagination.js");

class PostController {
  async show(req, res) {
    try {
      const limit = req.query.limit ?? 5;
      const title = req.query.title ?? "";
      const page = req.query.page ?? 1;

      // console.log(limit);

      const post = await Posts.findAll(
        paginate(
          {
            where: { title: { [Op.like]: "%" + title + "%" } },
            include: [{ model: Category, as: "Categories" }],
          },
          {
            page: parseInt(page),
            pageSize: parseInt(limit),
          }
        )
      );

      return res.json({
        code: 200,
        message: `${post.length} data sudah diterima`,
        count: post.length,
        data: post,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

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
        where: { id: id },
        include: [
          { model: Category, as: "Categories" },
          // { model:postcategories, as:'PostCategories',},
        ],
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

  async storePostCategories(req, res) {
    try {
      const { postId, categoryId } = req.body;

      // check postId
      const post = await Posts.findByPk(postId);
      if (!post) {
        return res.status(400).json({ message: "Post not found" });
      }

      // check Category Id
      const category = await Category.findByPk(categoryId);
      if (!category) {
        return res.status(400).json({ message: "Category Not Found" });
      }

      //cek jika sudah ada kategori yang sama dengan categoryId yg diinputkan
      const isAlreadyHaveThisCategory = await postcategories.findOne({
        where: { postId: postId, categoryId: categoryId },
      });
      if (isAlreadyHaveThisCategory) {
        return res
          .status(409)
          .json({ message: "The category has been added." });
      }

      const postCategories = await postcategories.create({
        postId,
        categoryId,
      });

      return res.json({
        code: 201,
        message: "Data berhasil dibuat",
        data: postCategories,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

  async destroy(req, res) {
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

  async update(req, res) {
    try {
      const { id } = req.params;
      const { title, description, categoryId, status } = req.body;

      const post = await Posts.findOne({
        where: { id },
        include: [{ model: postcategories, as: "PostCategories" }],
      });

      if (post.title == title) {
        return res.status(400).json({ message: "title is already use" });
      }

      const slug = slugify(title, {
        replacement: "-",
        lower: true,
        strict: true,
      });

      const editPost = await Posts.update(
        {
          title,
          description,
          status,
          slug,
        },
        { where: { id: id } }
      );

      const result = await Posts.findOne({where:{id:id}});
      return res.json({
        code:200,
        message:"data berhasil diperbaharui",
        data:result,
      })
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }
}

module.exports = new PostController();
