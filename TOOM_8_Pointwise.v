
`timescale 1ns/1ps

module TOOM_8_Pointwise (
    input signed [128:0] a0,
    input signed [128:0] b0,
    input signed [131:0] a1, a2, b1, b2,
    input signed [138:0] a3, a4, b3, b4,
    input signed [143:0] a5, a6, b5, b6,
    input signed [147:0] a7, a8, b7, b8,
    input signed [148:0] a9, a10, b9, b10, 
    input signed [149:0] a11, a12, b11, b12,
    input signed [154:0] a13, b13,
    input signed [128:0] ainf, binf,
    
    output signed [257:0] p0,   
    output signed [263:0] p1, p2,  
    output signed [277:0] p3, p4,  
    output signed [287:0] p5, p6,  
    output signed [295:0] p7, p8,  
    output signed [297:0] p9, p10, 
    output signed [299:0] p11, p12, 
    output signed [309:0] p13,
    output signed [257:0] p14
);

  
     
    assign p0 = a0  * b0;
    assign p1 = a1  * b1;
    assign p2 = a2  * b2;
    assign p3 = a3  * b3;
    assign p4 = a4  * b4;
    assign p5 = a5  * b5;
    assign p6 = a6  * b6;
    assign p7 = a7  * b7;
    assign p8 = a8  * b8;
    assign p9 = a9  * b9;
    
    assign p10 = a10 * b10;
    assign p11 = a11 * b11;
    assign p12 = a12 * b12;
    assign p13 = a13 * b13;
    assign p14 = ainf * binf;
      
endmodule
