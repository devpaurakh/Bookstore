import express from "express";
import { conndectDB } from "./config/db.js";
import path from "path";
import productRouter from "./routes/product.routes.js";

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;

const __dirname = path.resolve();

//read

app.use("/api/products", productRouter);

if (process.env.NODE_ENV === "production") {
  app.use(express.static(path.join(__dirname, "/frontend/dist")));
  app.get("*", (req, res) => {
    res.sendFile(path.resolve(__dirname, "Frontend", "dist", "index.html"));
  });
}

app.listen(3000, () => {
  conndectDB();
  console.log("http://localhost:" + PORT);
});
