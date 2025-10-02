`timescale 1ns / 1ps

module TOOM_8_Splitting_TB();

    reg clk;
    reg [1023:0] A, B;
    wire [2047:0] product;

    
    wire [128:0] A_chunk0_out, A_chunk1_out, A_chunk2_out, A_chunk3_out,
                 A_chunk4_out, A_chunk5_out, A_chunk6_out, A_chunk7_out;
    wire [128:0] B_chunk0_out, B_chunk1_out, B_chunk2_out, B_chunk3_out,
                 B_chunk4_out, B_chunk5_out, B_chunk6_out, B_chunk7_out;

    
    TOOM_8_Splitting DUT (
        .clk(clk),
        .X(A),
        .Y(B),
        .product(product),
        .A_chunk0(A_chunk0_out),
        .A_chunk1(A_chunk1_out),
        .A_chunk2(A_chunk2_out),
        .A_chunk3(A_chunk3_out),
        .A_chunk4(A_chunk4_out),
        .A_chunk5(A_chunk5_out),
        .A_chunk6(A_chunk6_out),
        .A_chunk7(A_chunk7_out),

        .B_chunk0(B_chunk0_out),
        .B_chunk1(B_chunk1_out),
        .B_chunk2(B_chunk2_out),
        .B_chunk3(B_chunk3_out),
        .B_chunk4(B_chunk4_out),
        .B_chunk5(B_chunk5_out),
        .B_chunk6(B_chunk6_out),
        .B_chunk7(B_chunk7_out)
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
        
        @(posedge clk);
        A = {128'd8, 128'd7, 128'd6, 128'd5,
             128'd4, 128'd3, 128'd2, 128'd253};
        B = {128'd8, 128'd7, 128'd6, 128'd5,
             128'd4, 128'd3, 128'd2, 128'd253};

        @(posedge clk);

       #20 $finish;
    end

endmodule