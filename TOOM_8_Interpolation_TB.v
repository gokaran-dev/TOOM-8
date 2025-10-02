`timescale 1ns / 1ps

module TOOM_8_TB();

    reg clk;
    reg [1023:0] A, B;
    wire [2047:0] product;
    wire signed [290:0]  c0_scaled;
    wire signed [363:0]  c1_scaled;
    wire signed [359:0]  c2_scaled;
    wire signed [368:0]  c3_scaled;
    wire signed [353:0]  c4_scaled;
    wire signed [364:0]  c5_scaled;
    wire signed [351:0]  c6_scaled;
    wire signed [349:0]  c7_scaled;
    wire signed [338:0]  c8_scaled;
    wire signed [333:0]  c9_scaled;
    wire signed [329:0]  c10_scaled;
    wire signed [319:0]  c11_scaled;
    wire signed [309:0]  c12_scaled;
    wire signed [295:0]  c13_scaled;
    wire signed [291:0]  c14_scaled;


      TOOM_8 DUT (
        .clk(clk),
        .X(A),
        .Y(B),
        .product(product),
        
        .c0_scaled(c0_scaled),
        .c1_scaled(c1_scaled),
        .c2_scaled(c2_scaled),
        .c3_scaled(c3_scaled),
        .c4_scaled(c4_scaled),
        .c5_scaled(c5_scaled),
        .c6_scaled(c6_scaled),
        .c7_scaled(c7_scaled),
        .c8_scaled(c8_scaled),
        .c9_scaled(c9_scaled),
        .c10_scaled(c10_scaled),
        .c11_scaled(c11_scaled),
        .c12_scaled(c12_scaled),
        .c13_scaled(c13_scaled),
        .c14_scaled(c14_scaled)
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
