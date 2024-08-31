import {
  Container,
  VStack,
  Text,
  CircularProgress,
  SimpleGrid,
} from "@chakra-ui/react"; // Import Text component
import React, { useEffect } from "react";
import { Link } from "react-router-dom";
import { useProductStore } from "../store/product";
import ProductCard from "../component/ProductCard";

const Homepage = () => {
  const { fetchProduct, products } = useProductStore();
  useEffect(() => {
    fetchProduct();
  }, [fetchProduct]);

  console.log("products", products);
  return (
    <Container maxW="container.xl" py={12}>
      {" "}
      {/* Corrected maxW and container size */}
      <VStack spacing={8}>
        <Text
          fontSize={{ base: "22px", sm: "28px" }} // Use "px" for sizes
          fontWeight={"bold"}
          textTransform={"uppercase"}
          textAlign={"center"}
          bgGradient={"linear(to-r, cyan.400, blue.400)"}
          bgClip={"text"}
        >
          Avaiable Products
        </Text>

        <SimpleGrid
          columns={{
            base: 1,
            md: 2,
            lg: 3,
          }}
          spacing={10}
          w={"full"}
        >
          {products.map((products) => (
            <ProductCard key={products._id} product={products}></ProductCard>
          ))}
        </SimpleGrid>

        {products.length === 0 && (
          <>
            <Text
              textAlign={"center"}
              fontWeight={"bold"}
              fontSize={18}
              color={"gray.500"}
            >
              No Product Found{" "}
              <Link to={"/create"}>
                <Text
                  as="span"
                  fontSize={18}
                  color={"blue.500"}
                  _hover={{ textDecoration: "underline" }}
                >
                  Add New Product
                </Text>
              </Link>
            </Text>
            <CircularProgress isIndeterminate color="blue.500" />
          </>
        )}
      </VStack>

      
    </Container>

  );
};

export default Homepage;
