import {
  Box,
  Button,
  Container,
  Heading,
  Input, // Make sure to import Input
  useColorModeValue,
  VStack,
  useToast
} from "@chakra-ui/react";
import React, { useState } from "react";
import { useProductStore } from "../store/product";

const CreatePage = () => {
  // Correct use of useState
  const [newProduct, setNewProduct] = useState({
    name: "",
    price: "",
    image: "",
  });

  const {createProduct} = useProductStore();
  const toast = useToast()
  const hendleAddProduct = async () => {

   const {success, message} = await createProduct(newProduct)


   if(!success){
    toast({
      title: 'Error',
      description: message,
      status: 'error',
      isClosable: true,
    })
   }
   else{
    toast({
      title: 'Product created.',
      description: message,
      status: 'success',
      isClosable: true,
    })
   }

   setNewProduct({ name:"", price:"", image:""})
    
  }

  
  return (
    <Container maxW={"container.sm"}>
      <VStack spacing={8}>
        <Heading as={"h1"} size={"2xl"} textAlign={"center"} mb={8}>
          Create a new product
        </Heading>

        <Box
          w={"full"}
          bg={useColorModeValue("white", "gray.800")}
          p={4}
          rounded={"lg"}
          shadow={"md"}
        >
          <VStack spacing={4}>
            <Input
              placeholder={"Product Name"}
              name="name"
              value={newProduct.name} // Corrected value assignment
              onChange={(e) =>
                setNewProduct({ ...newProduct, name: e.target.value })
              }
            />

            <Input
              placeholder={"Price"}
              name="price" // Corrected name attribute
              value={newProduct.price} // Corrected value assignment
              onChange={(e) =>
                setNewProduct({ ...newProduct, price: e.target.value })
              }
            />

            <Input
              placeholder={"Image URL"}
              name="image" // Corrected name attribute
              value={newProduct.image} // Corrected value assignment
              onChange={(e) =>
                setNewProduct({ ...newProduct, image: e.target.value })
              }
            />

            <Button colorScheme="blue" onClick={hendleAddProduct} w={"full"}>
              {" "}
              Add Product
            </Button>
          </VStack>
        </Box>
      </VStack>
    </Container>
  );
};

export default CreatePage;
