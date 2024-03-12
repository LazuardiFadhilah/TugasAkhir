const multer = require("multer");
const { Files } = require("../models");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./src/uploads");
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const formData = multer({ storage: storage });

class FilesController {
async  store(req, res) {
 const dochanlder = formData.single("document")
 dochanlder(req, res, async (err) => {
    if (err) {
      res.json({ message: "error", error: err });
    }
    try {
      const filename = req.file.originalname;
      const type = req.file.mimetype;
      const path = req.file.path;
      console.log({filename, type, path});

      const file = await Files.create({
        filename: filename,
        type: type,
        url: `http://localhost:3000/${path}`,
        path: path,
      });
      console.log(file);
      res.json({
        code: 201,
        message: `Berhasil menambahkan data`,
        "data": file,
      });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  });
  }
}

module.exports = new FilesController();
