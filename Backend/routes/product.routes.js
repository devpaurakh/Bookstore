import express from "express";

import {
  createProduct,
  deleteProduct,
  getProducts,
  updateProduct,
} from "../controllers/product.controller.js";

const router = express.Router();

router.get("/", getProducts);

//create
router.post("/", createProduct);

//update

router.put("/:id", updateProduct);

//delete

router.delete("/:id", deleteProduct);

export default router;
