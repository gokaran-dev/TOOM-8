`timescale 1ns / 1ps

module TOOM_8_TB();

    reg clk;
    reg [1023:0] A, B;
    wire [2047:0] product;
    wire signed [257:0] p0;    
    wire signed [263:0] p1, p2;  
    wire signed [277:0] p3, p4;  
    wire signed [287:0] p5, p6;  
    wire signed [295:0] p7, p8;  
    wire signed [297:0] p9, p10; 
    wire signed [299:0] p11, p12; 
    wire signed [309:0] p13;     
    wire signed [257:0] p14;


    TOOM_8 DUT (
        .clk(clk),
        .X(A),
        .Y(B),
        .product(product),
        .p0(p0),
        .p1(p1),
        .p2(p2),
        .p3(p3),
        .p4(p4),
        .p5(p5),
        .p6(p6),
        .p7(p7),
        .p8(p8),
        .p9(p9),
        .p10(p10),
        .p11(p11),
        .p12(p12),
        .p13(p13),
        .p14(p14)
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
      
        A = {128'd8, 128'd7, 128'd6, 128'd5,
             128'd4, 128'd3, 128'd2, 128'd253};
        B = {128'd8, 128'd7, 128'd6, 128'd5,
             128'd4, 128'd3, 128'd2, 128'd253};

        #20 $finish;
    end

endmodule
