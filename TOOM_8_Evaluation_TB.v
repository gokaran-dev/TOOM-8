`timescale 1ns / 1ps

module TOOM_8_Evaluation_TB();

    reg clk;
    reg [1023:0] A, B;
    wire [2047:0] product;
    wire signed [128:0] a0, b0;
    wire signed [131:0] a1, a2, b1, b2;
    wire signed [138:0] a3, a4, b3, b4;
    wire signed [143:0] a5, a6, b5, b6;
    wire signed [147:0] a7, a8, b7, b8;
    wire signed [148:0] a9, a10, b9, b10; 
    wire signed [149:0] a11, a12, b11, b12;
    wire signed [154:0] a13, b13;
    wire signed [128:0] ainf, binf;

    
    TOOM_8_Evaluation DUT (
        .clk(clk),
        .X(A),
        .Y(B),
        .product(product),
        .a0(a0),
        .b0(b0),
        .a1(a1),
        .a2(a2),
        .b1(b1),
        .b2(b2),
        .a3(a3),
        .a4(a4),
        .b3(b3),
        .b4(b4),
        .a5(a5),
        .a6(a6),
        .b5(b5),
        .b6(b6),
        .a7(a7),
        .a8(a8),
        .b7(b7),
        .b8(b8),
        .a9(a9),
        .b9(b9),
        .a10(a10),
        .b10(b10),
        .a11(a11),
        .b11(b11),
        .a12(a12),
        .b12(b12),
        .a13(a13),
        .b13(b13),
        .ainf(ainf),
        .binf(binf)     
    );

    //clock generation
    always #5 clk = ~clk;
    
    //initialization
    initial begin
        clk = 0; 
        A = 1024'd0; 
        B = 1024'd0;
    end
        
    //stimulus
    initial begin
        #110;
        // Set chunks explicitly (low chunk = 1, high chunk = 8)
        A = {128'd8, 128'd7, 128'd6, 128'd5,
             128'd4, 128'd3, 128'd2, 128'd253};
        B = {128'd8, 128'd7, 128'd6, 128'd5,
             128'd4, 128'd3, 128'd2, 128'd253};

        #20 $finish;
    end

endmodule
