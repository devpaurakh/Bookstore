import express from "express";
import { conndectDB } from "./config/db.js";
import Product from "./model/product.model.js";

const app = express();
app.use(express.json());

//create
app.post("/api/products", async (req, res) => {
  const product = req.body;
  if (!product.name || !product.price || !product.image) {
    res
      .status(400)
      .json({ success: false, message: "Please fill all the fields" });
    return;
  }
  const newPoriduct = new Product(product);
  try {
    const createdProduct = await newPoriduct.save();
    res.status(201).json({
      success: true,
      message: "Product successfully created",
      data: createdProduct,
    });
  } catch (error) {
    res.status(500).json({ success: false, message: "Internal Server Error" });
  }
});

//delete

app.delete("/api/products/:id", async (req, res) => {
  try {
    const { id } = req.params;
    await Product.findByIdAndDelete(id);
    res.json({ success: true, message: "Product deleted successfully" });
  } catch (error) {
    res.status(500).json({ success: false, message: "Internal Server Error" });
  }
});

app.listen(3000, () => {
  conndectDB();
  console.log("http://localhost:3000");
});
