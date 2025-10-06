`timescale 1ns/1ps

module TOOM_8_Evaluation (
    input  clk,
    input  [1023:0] X,
    input  [1023:0] Y,
    output reg [2047:0] product,
    output signed [128:0] a0,
    output signed [128:0] b0,
    output signed [131:0] a1, a2, b1, b2,
    output signed [138:0] a3, a4, b3, b4,
    output signed [143:0] a5, a6, b5, b6,
    output signed [147:0] a7, a8, b7, b8,
    output signed [148:0] a9, a10, b9, b10, //bit width changed from 149 to 156
    output signed [149:0] a11, a12, b11, b12,
    output signed [154:0] a13, b13,
    output signed [128:0] ainf, binf
);

    reg [1023:0] A;
    reg [1023:0] B;
    wire [2047:0] final_value;

    
    wire [128:0] A_chunk0, A_chunk1, A_chunk2, A_chunk3;
    wire [128:0] A_chunk4, A_chunk5, A_chunk6, A_chunk7;
    wire [128:0] B_chunk0, B_chunk1, B_chunk2, B_chunk3;
    wire [128:0] B_chunk4, B_chunk5, B_chunk6, B_chunk7;

    always @(posedge clk) begin
        A <= X;
        B <= Y;
        product <= final_value;
    end

    // Assign chunk internally
    assign A_chunk0 = {A[127], A[127:0]};
    assign A_chunk1 = {A[255], A[255:128]};
    assign A_chunk2 = {A[383], A[383:256]};
    assign A_chunk3 = {A[511], A[511:384]};
    assign A_chunk4 = {A[639], A[639:512]};
    assign A_chunk5 = {A[767], A[767:640]};
    assign A_chunk6 = {A[895], A[895:768]};
    assign A_chunk7 = {A[1023], A[1023:896]};

    assign B_chunk0 = {B[127], B[127:0]};
    assign B_chunk1 = {B[255], B[255:128]};
    assign B_chunk2 = {B[383], B[383:256]};
    assign B_chunk3 = {B[511], B[511:384]};
    assign B_chunk4 = {B[639], B[639:512]};
    assign B_chunk5 = {B[767], B[767:640]};
    assign B_chunk6 = {B[895], B[895:768]};
    assign B_chunk7 = {B[1023], B[1023:896]};

     //for evaluation point 0 
     //wire signed [128:0] a0 = A_chunk0;
     //wire signed [128:0] b0 = B_chunk0;
    
    assign a0 = A_chunk0;
    assign b0 = B_chunk0;
     
     //for evaluation point 1 and -1
     //wire signed [131:0] a1 = A_chunk0 + A_chunk1 + A_chunk2 + A_chunk3 + A_chunk4 + A_chunk5 + A_chunk6 + A_chunk7;
     //wire signed [131:0] a2 = A_chunk0 - A_chunk1 + A_chunk2 - A_chunk3 + A_chunk4 - A_chunk5 + A_chunk6 - A_chunk7;
     assign a1 = A_chunk0 + A_chunk1 + A_chunk2 + A_chunk3 + A_chunk4 + A_chunk5 + A_chunk6 + A_chunk7;
     assign a2 = A_chunk0 - A_chunk1 + A_chunk2 - A_chunk3 + A_chunk4 - A_chunk5 + A_chunk6 - A_chunk7;
     
     //wire signed [131:0] b1  = B_chunk0 + B_chunk1 + B_chunk2 + B_chunk3 + B_chunk4 + B_chunk5 + B_chunk6 + B_chunk7;
     //wire signed [131:0] b2  = B_chunk0 - B_chunk1 + B_chunk2 - B_chunk3 + B_chunk4 - B_chunk5 + B_chunk6 - B_chunk7;
     assign b1  = B_chunk0 + B_chunk1 + B_chunk2 + B_chunk3 + B_chunk4 + B_chunk5 + B_chunk6 + B_chunk7;
     assign b2  = B_chunk0 - B_chunk1 + B_chunk2 - B_chunk3 + B_chunk4 - B_chunk5 + B_chunk6 - B_chunk7;
     
     //for evaluation point 2 and -2
     //wire signed [138:0] a3 = A_chunk0 + (A_chunk1<<<1) + (A_chunk2<<<2) + (A_chunk3<<<3) + (A_chunk4<<<4) + (A_chunk5<<<5) + (A_chunk6<<<6) + (A_chunk7<<<7);
     //wire signed [138:0] a4 = A_chunk0 - (A_chunk1<<<1) + (A_chunk2<<<2) - (A_chunk3<<<3) + (A_chunk4<<<4) - (A_chunk5<<<5) + (A_chunk6<<<6) - (A_chunk7<<<7);
     
     assign a3 = A_chunk0 + (A_chunk1<<<1) + (A_chunk2<<<2) + (A_chunk3<<<3) + (A_chunk4<<<4) + (A_chunk5<<<5) + (A_chunk6<<<6) + (A_chunk7<<<7);
     assign a4 = A_chunk0 - (A_chunk1<<<1) + (A_chunk2<<<2) - (A_chunk3<<<3) + (A_chunk4<<<4) - (A_chunk5<<<5) + (A_chunk6<<<6) - (A_chunk7<<<7);
     
     //wire signed [138:0] b3  = B_chunk0 + (B_chunk1<<<1) + (B_chunk2<<<2) + (B_chunk3<<<3) + (B_chunk4<<<4) + (B_chunk5<<<5) + (B_chunk6<<<6) + (B_chunk7<<<7);
     //wire signed [138:0] b4  = B_chunk0 - (B_chunk1<<<1) + (B_chunk2<<<2) - (B_chunk3<<<3) + (B_chunk4<<<4) - (B_chunk5<<<5) + (B_chunk6<<<6) - (B_chunk7<<<7);
     
     assign b3  = B_chunk0 + (B_chunk1<<<1) + (B_chunk2<<<2) + (B_chunk3<<<3) + (B_chunk4<<<4) + (B_chunk5<<<5) + (B_chunk6<<<6) + (B_chunk7<<<7);
     assign b4  = B_chunk0 - (B_chunk1<<<1) + (B_chunk2<<<2) - (B_chunk3<<<3) + (B_chunk4<<<4) - (B_chunk5<<<5) + (B_chunk6<<<6) - (B_chunk7<<<7);
     
     //for evaluation point 3 and -3
     //wire signed [143:0] a5 = A_chunk0 + ((A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 3) + A_chunk2) + ((A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 6) + (A_chunk4 <<< 4) + A_chunk4) + ((A_chunk5 <<< 7) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 9) + (A_chunk6 <<< 7) + (A_chunk6 <<< 6) + (A_chunk6 <<< 4) + (A_chunk6 <<< 3) + A_chunk6) + ( (A_chunk7 <<< 11) + (A_chunk7 <<< 7) + (A_chunk7 <<< 3) + (A_chunk7 <<< 1) + A_chunk7);                       
     //wire signed [143:0] a6 = A_chunk0 - ((A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 3) + A_chunk2) - ((A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 6) + (A_chunk4 <<< 4) + A_chunk4) - ((A_chunk5 <<< 7) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 9) + (A_chunk6 <<< 7) + (A_chunk6 <<< 6) + (A_chunk6 <<< 4) + (A_chunk6 <<< 3) + A_chunk6) - ( (A_chunk7 <<< 11) + (A_chunk7 <<< 7) + (A_chunk7 <<< 3) + (A_chunk7 <<< 1) + A_chunk7);
     
     assign a5 = A_chunk0 + ((A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 3) + A_chunk2) + ((A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 6) + (A_chunk4 <<< 4) + A_chunk4) + ((A_chunk5 <<< 7) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 9) + (A_chunk6 <<< 7) + (A_chunk6 <<< 6) + (A_chunk6 <<< 4) + (A_chunk6 <<< 3) + A_chunk6) + ( (A_chunk7 <<< 11) + (A_chunk7 <<< 7) + (A_chunk7 <<< 3) + (A_chunk7 <<< 1) + A_chunk7);                       
     assign a6 = A_chunk0 - ((A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 3) + A_chunk2) - ((A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 6) + (A_chunk4 <<< 4) + A_chunk4) - ((A_chunk5 <<< 7) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 9) + (A_chunk6 <<< 7) + (A_chunk6 <<< 6) + (A_chunk6 <<< 4) + (A_chunk6 <<< 3) + A_chunk6) - ( (A_chunk7 <<< 11) + (A_chunk7 <<< 7) + (A_chunk7 <<< 3) + (A_chunk7 <<< 1) + A_chunk7);
     //wire signed [143:0] b5  = B_chunk0 + ((B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 3) + B_chunk2) + ((B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 6) + (B_chunk4 <<< 4) + B_chunk4) + ((B_chunk5 <<< 7) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 9) + (B_chunk6 <<< 7) + (B_chunk6 <<< 6) + (B_chunk6 <<< 4) + (B_chunk6 <<< 3) + B_chunk6) + ( (B_chunk7 <<< 11) + (B_chunk7 <<< 7) + (B_chunk7 <<< 3) + (B_chunk7 <<< 1) + B_chunk7);                       
     //wire signed [143:0] b6  = B_chunk0 - ((B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 3) + B_chunk2) - ((B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 6) + (B_chunk4 <<< 4) + B_chunk4) - ((B_chunk5 <<< 7) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 9) + (B_chunk6 <<< 7) + (B_chunk6 <<< 6) + (B_chunk6 <<< 4) + (B_chunk6 <<< 3) + B_chunk6) - ( (B_chunk7 <<< 11) + (B_chunk7 <<< 7) + (B_chunk7 <<< 3) + (B_chunk7 <<< 1) + B_chunk7);
     
     assign b5  = B_chunk0 + ((B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 3) + B_chunk2) + ((B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 6) + (B_chunk4 <<< 4) + B_chunk4) + ((B_chunk5 <<< 7) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 9) + (B_chunk6 <<< 7) + (B_chunk6 <<< 6) + (B_chunk6 <<< 4) + (B_chunk6 <<< 3) + B_chunk6) + ( (B_chunk7 <<< 11) + (B_chunk7 <<< 7) + (B_chunk7 <<< 3) + (B_chunk7 <<< 1) + B_chunk7);                       
     assign b6  = B_chunk0 - ((B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 3) + B_chunk2) - ((B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 6) + (B_chunk4 <<< 4) + B_chunk4) - ((B_chunk5 <<< 7) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 9) + (B_chunk6 <<< 7) + (B_chunk6 <<< 6) + (B_chunk6 <<< 4) + (B_chunk6 <<< 3) + B_chunk6) - ( (B_chunk7 <<< 11) + (B_chunk7 <<< 7) + (B_chunk7 <<< 3) + (B_chunk7 <<< 1) + B_chunk7);
     
     //for evaluation point 4 and -4
     //wire signed [145:0] a7 = A_chunk0 + (A_chunk1<<<2) + (A_chunk2<<<4) + (A_chunk3<<<6) + (A_chunk4<<<8) + (A_chunk5<<<10) + (A_chunk6<<<12) + (A_chunk7<<<14);
     //wire signed [145:0] a8 = A_chunk0 - (A_chunk1<<<2) + (A_chunk2<<<4) - (A_chunk3<<<6) + (A_chunk4<<<8) - (A_chunk5<<<10) + (A_chunk6<<<12) - (A_chunk7<<<14);
     
     assign a7 = A_chunk0 + (A_chunk1<<<2) + (A_chunk2<<<4) + (A_chunk3<<<6) + (A_chunk4<<<8) + (A_chunk5<<<10) + (A_chunk6<<<12) + (A_chunk7<<<14);
     assign a8 = A_chunk0 - (A_chunk1<<<2) + (A_chunk2<<<4) - (A_chunk3<<<6) + (A_chunk4<<<8) - (A_chunk5<<<10) + (A_chunk6<<<12) - (A_chunk7<<<14);
     
     //wire signed [145:0] b7  = B_chunk0 + (B_chunk1<<<2) + (B_chunk2<<<4) + (B_chunk3<<<6) + (B_chunk4<<<8) + (B_chunk5<<<10) + (B_chunk6<<<12) + (B_chunk7<<<14);
     //wire signed [145:0] b8  = B_chunk0 - (B_chunk1<<<2) + (B_chunk2<<<4) - (B_chunk3<<<6) + (B_chunk4<<<8) - (B_chunk5<<<10) + (B_chunk6<<<12) - (B_chunk7<<<14);
     
     assign b7  = B_chunk0 + (B_chunk1<<<2) + (B_chunk2<<<4) + (B_chunk3<<<6) + (B_chunk4<<<8) + (B_chunk5<<<10) + (B_chunk6<<<12) + (B_chunk7<<<14);
     assign b8  = B_chunk0 - (B_chunk1<<<2) + (B_chunk2<<<4) - (B_chunk3<<<6) + (B_chunk4<<<8) - (B_chunk5<<<10) + (B_chunk6<<<12) - (B_chunk7<<<14);
     
     //for evaluation point 5 and -5
     //wire signed [148:0] a9 = A_chunk0 + ((A_chunk1 <<< 2) + A_chunk1) + ((A_chunk2 <<< 4) + (A_chunk2 <<< 3) + A_chunk2) + ((A_chunk3 <<< 6) + (A_chunk3 <<< 5) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 2) + A_chunk3) + ((A_chunk4 <<< 9) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + (A_chunk4 <<< 4) + A_chunk4) + ((A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 2) + A_chunk5) + ((A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 11) + (A_chunk6 <<< 8) + (A_chunk6 <<< 3) + A_chunk6) + ((A_chunk7 <<< 16) + (A_chunk7 <<< 13) + (A_chunk7 <<< 12) + (A_chunk7 <<< 8) + (A_chunk7 <<< 5) + (A_chunk7 <<< 3) + (A_chunk7 <<< 2) + A_chunk7);  
     //wire signed [148:0] a10 = A_chunk0 - ((A_chunk1 <<< 2) + A_chunk1) + ((A_chunk2 <<< 4) + (A_chunk2 <<< 3) + A_chunk2) - ((A_chunk3 <<< 6) + (A_chunk3 <<< 5) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 2) + A_chunk3) + ((A_chunk4 <<< 9) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + (A_chunk4 <<< 4) + A_chunk4) - ((A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 2) + A_chunk5) + ((A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 11) + (A_chunk6 <<< 8) + (A_chunk6 <<< 3) + A_chunk6) + ((A_chunk7 <<< 16) - (A_chunk7 <<< 13) + (A_chunk7 <<< 12) + (A_chunk7 <<< 8) + (A_chunk7 <<< 5) + (A_chunk7 <<< 3) + (A_chunk7 <<< 2) + A_chunk7);  
     
     assign a9 = A_chunk0 + ((A_chunk1 <<< 2) + A_chunk1) + ((A_chunk2 <<< 4) + (A_chunk2 <<< 3) + A_chunk2) + ((A_chunk3 <<< 6) + (A_chunk3 <<< 5) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 2) + A_chunk3) + ((A_chunk4 <<< 9) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + (A_chunk4 <<< 4) + A_chunk4) + ((A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 2) + A_chunk5) + ((A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 11) + (A_chunk6 <<< 8) + (A_chunk6 <<< 3) + A_chunk6) + ((A_chunk7 <<< 16) + (A_chunk7 <<< 13) + (A_chunk7 <<< 12) + (A_chunk7 <<< 8) + (A_chunk7 <<< 5) + (A_chunk7 <<< 3) + (A_chunk7 <<< 2) + A_chunk7);  
     assign a10 = A_chunk0 - ((A_chunk1 <<< 2) + A_chunk1) + ((A_chunk2 <<< 4) + (A_chunk2 <<< 3) + A_chunk2) - ((A_chunk3 <<< 6) + (A_chunk3 <<< 5) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 2) + A_chunk3) + ((A_chunk4 <<< 9) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + (A_chunk4 <<< 4) + A_chunk4) - ((A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 2) + A_chunk5) + ((A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 11) + (A_chunk6 <<< 8) + (A_chunk6 <<< 3) + A_chunk6) + ((A_chunk7 <<< 16) - (A_chunk7 <<< 13) + (A_chunk7 <<< 12) + (A_chunk7 <<< 8) + (A_chunk7 <<< 5) + (A_chunk7 <<< 3) + (A_chunk7 <<< 2) + A_chunk7);  
     
     //wire signed [148:0] b9 = B_chunk0 + ((B_chunk1 <<< 2) + B_chunk1) + ((B_chunk2 <<< 4) + (B_chunk2 <<< 3) + B_chunk2) + ((B_chunk3 <<< 6) + (B_chunk3 <<< 5) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 2) + B_chunk3) + ((B_chunk4 <<< 9) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + (B_chunk4 <<< 4) + B_chunk4) + ((B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 2) + B_chunk5) + ((B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 11) + (B_chunk6 <<< 8) + (B_chunk6 <<< 3) + B_chunk6) + ((B_chunk7 <<< 16) + (B_chunk7 <<< 13) + (B_chunk7 <<< 12) + (B_chunk7 <<< 8) + (B_chunk7 <<< 5) + (B_chunk7 <<< 3) + (B_chunk7 <<< 2) + B_chunk7);  
     //wire signed [148:0] b10 = B_chunk0 - ((B_chunk1 <<< 2) + B_chunk1) + ((B_chunk2 <<< 4) + (B_chunk2 <<< 3) + B_chunk2) - ((B_chunk3 <<< 6) + (B_chunk3 <<< 5) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 2) + B_chunk3) + ((B_chunk4 <<< 9) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + (B_chunk4 <<< 4) + B_chunk4) - ((B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 2) + B_chunk5) + ((B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 11) + (B_chunk6 <<< 8) + (B_chunk6 <<< 3) + B_chunk6) + ((B_chunk7 <<< 16) - (B_chunk7 <<< 13) + (B_chunk7 <<< 12) + (B_chunk7 <<< 8) + (B_chunk7 <<< 5) + (B_chunk7 <<< 3) + (B_chunk7 <<< 2) + B_chunk7);  
     
     assign b9 = B_chunk0 + ((B_chunk1 <<< 2) + B_chunk1) + ((B_chunk2 <<< 4) + (B_chunk2 <<< 3) + B_chunk2) + ((B_chunk3 <<< 6) + (B_chunk3 <<< 5) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 2) + B_chunk3) + ((B_chunk4 <<< 9) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + (B_chunk4 <<< 4) + B_chunk4) + ((B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 2) + B_chunk5) + ((B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 11) + (B_chunk6 <<< 8) + (B_chunk6 <<< 3) + B_chunk6) + ((B_chunk7 <<< 16) + (B_chunk7 <<< 13) + (B_chunk7 <<< 12) + (B_chunk7 <<< 8) + (B_chunk7 <<< 5) + (B_chunk7 <<< 3) + (B_chunk7 <<< 2) + B_chunk7);  
     assign b10 = B_chunk0 - ((B_chunk1 <<< 2) + B_chunk1) + ((B_chunk2 <<< 4) + (B_chunk2 <<< 3) + B_chunk2) - ((B_chunk3 <<< 6) + (B_chunk3 <<< 5) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 2) + B_chunk3) + ((B_chunk4 <<< 9) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + (B_chunk4 <<< 4) + B_chunk4) - ((B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 2) + B_chunk5) + ((B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 11) + (B_chunk6 <<< 8) + (B_chunk6 <<< 3) + B_chunk6) + ((B_chunk7 <<< 16) - (B_chunk7 <<< 13) + (B_chunk7 <<< 12) + (B_chunk7 <<< 8) + (B_chunk7 <<< 5) + (B_chunk7 <<< 3) + (B_chunk7 <<< 2) + B_chunk7);  
     
     //for evaluation point 6 and -6
     //wire signed [149:0] a11 = A_chunk0 + ((A_chunk1 <<< 2) + (A_chunk1 <<< 1)) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 2)) + ((A_chunk3 <<< 7) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3)) + ((A_chunk4 <<< 10) + (A_chunk4 <<< 8) + (A_chunk4 <<< 4)) + ((A_chunk5 <<< 12) + (A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 9) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5)) + ((A_chunk6 <<< 15) + (A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 10) + (A_chunk6 <<< 9) + (A_chunk6 <<< 6)) + ((A_chunk7 <<< 18) + (A_chunk7 <<< 14) + (A_chunk7 <<< 10) + (A_chunk7 <<< 8) + (A_chunk7 <<< 7));
     //wire signed [149:0] a12 = A_chunk0 - ((A_chunk1 <<< 2) + (A_chunk1 <<< 1)) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 2)) - ((A_chunk3 <<< 7) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3)) + ((A_chunk4 <<< 10) + (A_chunk4 <<< 8) + (A_chunk4 <<< 4)) - ((A_chunk5 <<< 12) + (A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 9) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5)) + ((A_chunk6 <<< 15) + (A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 10) + (A_chunk6 <<< 9) + (A_chunk6 <<< 6)) - ((A_chunk7 <<< 18) + (A_chunk7 <<< 14) + (A_chunk7 <<< 10) + (A_chunk7 <<< 8) + (A_chunk7 <<< 7));                                 
     assign a11 = A_chunk0 + ((A_chunk1 <<< 2) + (A_chunk1 <<< 1)) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 2)) + ((A_chunk3 <<< 7) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3)) + ((A_chunk4 <<< 10) + (A_chunk4 <<< 8) + (A_chunk4 <<< 4)) + ((A_chunk5 <<< 12) + (A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 9) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5)) + ((A_chunk6 <<< 15) + (A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 10) + (A_chunk6 <<< 9) + (A_chunk6 <<< 6)) + ((A_chunk7 <<< 18) + (A_chunk7 <<< 14) + (A_chunk7 <<< 10) + (A_chunk7 <<< 8) + (A_chunk7 <<< 7));
     assign a12 = A_chunk0 - ((A_chunk1 <<< 2) + (A_chunk1 <<< 1)) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 2)) - ((A_chunk3 <<< 7) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3)) + ((A_chunk4 <<< 10) + (A_chunk4 <<< 8) + (A_chunk4 <<< 4)) - ((A_chunk5 <<< 12) + (A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 9) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5)) + ((A_chunk6 <<< 15) + (A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 10) + (A_chunk6 <<< 9) + (A_chunk6 <<< 6)) - ((A_chunk7 <<< 18) + (A_chunk7 <<< 14) + (A_chunk7 <<< 10) + (A_chunk7 <<< 8) + (A_chunk7 <<< 7));  
     
     assign b11 = B_chunk0 + ((B_chunk1 <<< 2) + (B_chunk1 <<< 1)) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 2)) + ((B_chunk3 <<< 7) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3)) + ((B_chunk4 <<< 10) + (B_chunk4 <<< 8) + (B_chunk4 <<< 4)) + ((B_chunk5 <<< 12) + (B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 9) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5)) + ((B_chunk6 <<< 15) + (B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 10) + (B_chunk6 <<< 9) + (B_chunk6 <<< 6)) + ((B_chunk7 <<< 18) + (B_chunk7 <<< 14) + (B_chunk7 <<< 10) + (B_chunk7 <<< 8) + (B_chunk7 <<< 7));
     assign b12 = B_chunk0 - ((B_chunk1 <<< 2) + (B_chunk1 <<< 1)) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 2)) - ((B_chunk3 <<< 7) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3)) + ((B_chunk4 <<< 10) + (B_chunk4 <<< 8) + (B_chunk4 <<< 4)) - ((B_chunk5 <<< 12) + (B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 9) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5)) + ((B_chunk6 <<< 15) + (B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 10) + (B_chunk6 <<< 9) + (B_chunk6 <<< 6)) - ((B_chunk7 <<< 18) + (B_chunk7 <<< 14) + (B_chunk7 <<< 10) + (B_chunk7 <<< 8) + (B_chunk7 <<< 7));   
     
     //wire signed [149:0] b11 = B_chunk0 + ((B_chunk1 <<< 2) + (B_chunk1 <<< 1)) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 2)) + ((B_chunk3 <<< 7) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3)) + ((B_chunk4 <<< 10) + (B_chunk4 <<< 8) + (B_chunk4 <<< 4)) + ((B_chunk5 <<< 12) + (B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 9) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5)) + ((B_chunk6 <<< 15) + (B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 10) + (B_chunk6 <<< 9) + (B_chunk6 <<< 6)) + ((B_chunk7 <<< 18) + (B_chunk7 <<< 14) + (B_chunk7 <<< 10) + (B_chunk7 <<< 8) + (B_chunk7 <<< 7));
     //wire signed [149:0] b12 = B_chunk0 - ((B_chunk1 <<< 2) + (B_chunk1 <<< 1)) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 2)) - ((B_chunk3 <<< 7) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3)) + ((B_chunk4 <<< 10) + (B_chunk4 <<< 8) + (B_chunk4 <<< 4)) - ((B_chunk5 <<< 12) + (B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 9) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5)) + ((B_chunk6 <<< 15) + (B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 10) + (B_chunk6 <<< 9) + (B_chunk6 <<< 6)) - ((B_chunk7 <<< 18) + (B_chunk7 <<< 14) + (B_chunk7 <<< 10) + (B_chunk7 <<< 8) + (B_chunk7 <<< 7));   
     
     //for evaluation poinr -7
     //wire signed [154:0] a13 = A_chunk0 - ((A_chunk1 <<< 2) + (A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 4) + A_chunk2) - ((A_chunk3 <<< 8) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 2) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 11) + (A_chunk4 <<< 8) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + A_chunk4) - ((A_chunk5 <<< 14) + (A_chunk5 <<< 8) + (A_chunk5 <<< 7) + (A_chunk5 <<< 5) + (A_chunk5 <<< 2) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 16) + (A_chunk6 <<< 15) + (A_chunk6 <<< 14) + (A_chunk6 <<< 11) + (A_chunk6 <<< 9) + (A_chunk6 <<< 8) + (A_chunk6 <<< 7) + (A_chunk6 <<< 4) + A_chunk6) - ((A_chunk7 <<< 19) + (A_chunk7 <<< 18) + (A_chunk7 <<< 15) + (A_chunk7 <<< 12) + (A_chunk7 <<< 7) + (A_chunk7 <<< 6) + (A_chunk7 <<< 5) + (A_chunk7 <<< 4) + (A_chunk7 <<< 2) + (A_chunk7 <<< 1) + A_chunk7);              
     //wire signed [154:0] b13 = B_chunk0 - ((B_chunk1 <<< 2) + (B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 4) + B_chunk2) - ((B_chunk3 <<< 8) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 2) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 11) + (B_chunk4 <<< 8) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + B_chunk4) - ((B_chunk5 <<< 14) + (B_chunk5 <<< 8) + (B_chunk5 <<< 7) + (B_chunk5 <<< 5) + (B_chunk5 <<< 2) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 16) + (B_chunk6 <<< 15) + (B_chunk6 <<< 14) + (B_chunk6 <<< 11) + (B_chunk6 <<< 9) + (B_chunk6 <<< 8) + (B_chunk6 <<< 7) + (B_chunk6 <<< 4) + B_chunk6) - ((B_chunk7 <<< 19) + (B_chunk7 <<< 18) + (B_chunk7 <<< 15) + (B_chunk7 <<< 12) + (B_chunk7 <<< 7) + (B_chunk7 <<< 6) + (B_chunk7 <<< 5) + (B_chunk7 <<< 4) + (B_chunk7 <<< 2) + (B_chunk7 <<< 1) + B_chunk7);
     
     assign a13 = A_chunk0 - ((A_chunk1 <<< 2) + (A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 4) + A_chunk2) - ((A_chunk3 <<< 8) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 2) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 11) + (A_chunk4 <<< 8) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + A_chunk4) - ((A_chunk5 <<< 14) + (A_chunk5 <<< 8) + (A_chunk5 <<< 7) + (A_chunk5 <<< 5) + (A_chunk5 <<< 2) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 16) + (A_chunk6 <<< 15) + (A_chunk6 <<< 14) + (A_chunk6 <<< 11) + (A_chunk6 <<< 9) + (A_chunk6 <<< 8) + (A_chunk6 <<< 7) + (A_chunk6 <<< 4) + A_chunk6) - ((A_chunk7 <<< 19) + (A_chunk7 <<< 18) + (A_chunk7 <<< 15) + (A_chunk7 <<< 12) + (A_chunk7 <<< 7) + (A_chunk7 <<< 6) + (A_chunk7 <<< 5) + (A_chunk7 <<< 4) + (A_chunk7 <<< 2) + (A_chunk7 <<< 1) + A_chunk7);              
     assign b13 = B_chunk0 - ((B_chunk1 <<< 2) + (B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 4) + B_chunk2) - ((B_chunk3 <<< 8) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 2) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 11) + (B_chunk4 <<< 8) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + B_chunk4) - ((B_chunk5 <<< 14) + (B_chunk5 <<< 8) + (B_chunk5 <<< 7) + (B_chunk5 <<< 5) + (B_chunk5 <<< 2) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 16) + (B_chunk6 <<< 15) + (B_chunk6 <<< 14) + (B_chunk6 <<< 11) + (B_chunk6 <<< 9) + (B_chunk6 <<< 8) + (B_chunk6 <<< 7) + (B_chunk6 <<< 4) + B_chunk6) - ((B_chunk7 <<< 19) + (B_chunk7 <<< 18) + (B_chunk7 <<< 15) + (B_chunk7 <<< 12) + (B_chunk7 <<< 7) + (B_chunk7 <<< 6) + (B_chunk7 <<< 5) + (B_chunk7 <<< 4) + (B_chunk7 <<< 2) + (B_chunk7 <<< 1) + B_chunk7);
     
     //for evaluation point inf
     //wire signed [128:0] ainf = A_chunk7;
     //wire signed [128:0] binf = B_chunk7;
     
     assign ainf = A_chunk7;
     assign binf = B_chunk7;
    
endmodule
