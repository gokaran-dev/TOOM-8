`timescale 1ns/1ps

module TOOM_8 (
    input  clk,
    input  reset_n,
    input  [1023:0] X,
    input  [1023:0] Y,
    output reg [2047:0] product 
);

    wire [128:0] A_chunk0, A_chunk1, A_chunk2, A_chunk3, A_chunk4, A_chunk5, A_chunk6, A_chunk7;
    wire [128:0] B_chunk0, B_chunk1, B_chunk2, B_chunk3, B_chunk4, B_chunk5, B_chunk6, B_chunk7;


    wire signed [128:0] a0, b0;
    wire signed [131:0] a1, a2, b1, b2;
    wire signed [138:0] a3, a4, b3, b4;
    wire signed [143:0] a5, a6, b5, b6;
    wire signed [147:0] a7, a8, b7, b8;
    wire signed [148:0] a9, a10, b9, b10; 
    wire signed [149:0] a11, a12, b11, b12;
    wire signed [154:0] a13, b13;
    wire signed [128:0] ainf, binf;


    wire signed [257:0] p0;   
    wire signed [263:0] p1, p2;   
    wire signed [277:0] p3, p4;   
    wire signed [287:0] p5, p6;   
    wire signed [295:0] p7, p8;   
    wire signed [297:0] p9, p10; 
    wire signed [299:0] p11, p12; 
    wire signed [309:0] p13;
    wire signed [257:0] p14;
    
    
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

    wire [2047:0] final_value_scaled;

    //STAGE 1: Splitting
    TOOM_8_Splitting u_splitting (
        .clk(clk),
        .X(X),
        .Y(Y),
        .A_chunk0(A_chunk0), .A_chunk1(A_chunk1), .A_chunk2(A_chunk2), .A_chunk3(A_chunk3),
        .A_chunk4(A_chunk4), .A_chunk5(A_chunk5), .A_chunk6(A_chunk6), .A_chunk7(A_chunk7),
        .B_chunk0(B_chunk0), .B_chunk1(B_chunk1), .B_chunk2(B_chunk2), .B_chunk3(B_chunk3),
        .B_chunk4(B_chunk4), .B_chunk5(B_chunk5), .B_chunk6(B_chunk6), .B_chunk7(B_chunk7)
    );

    //STAGE 2: Evaluation
    TOOM_8_Evaluation u_evaluation (
        .A_chunk0(A_chunk0), .A_chunk1(A_chunk1), .A_chunk2(A_chunk2), .A_chunk3(A_chunk3),
        .A_chunk4(A_chunk4), .A_chunk5(A_chunk5), .A_chunk6(A_chunk6), .A_chunk7(A_chunk7),
        .B_chunk0(B_chunk0), .B_chunk1(B_chunk1), .B_chunk2(B_chunk2), .B_chunk3(B_chunk3),
        .B_chunk4(B_chunk4), .B_chunk5(B_chunk5), .B_chunk6(B_chunk6), .B_chunk7(B_chunk7),
        .a0(a0), .b0(b0), 
        .a1(a1), .a2(a2), .b1(b1), .b2(b2),
        .a3(a3), .a4(a4), .b3(b3), .b4(b4), 
        .a5(a5), .a6(a6), .b5(b5), .b6(b6),
        .a7(a7), .a8(a8), .b7(b7), .b8(b8), 
        .a9(a9), .a10(a10), .b9(b9), .b10(b10),
        .a11(a11), .a12(a12), .b11(b11), .b12(b12), 
        .a13(a13), .b13(b13),
        .ainf(ainf), .binf(binf)
    );

    //STAGE 3: Pointwise Multiplication
    TOOM_8_Pointwise u_pointwise (
        .a0(a0), .b0(b0), 
        .a1(a1), .a2(a2), .b1(b1), .b2(b2),
        .a3(a3), .a4(a4), .b3(b3), .b4(b4), 
        .a5(a5), .a6(a6), .b5(b5), .b6(b6),
        .a7(a7), .a8(a8), .b7(b7), .b8(b8), 
        .a9(a9), .a10(a10), .b9(b9), .b10(b10),
        .a11(a11), .a12(a12), .b11(b11), .b12(b12), 
        .a13(a13), .b13(b13),
        .ainf(ainf), .binf(binf),
        
        .p0(p0), .p1(p1), .p2(p2), 
        .p3(p3), .p4(p4), .p5(p5),
        .p6(p6), .p7(p7), .p8(p8), 
        .p9(p9), .p10(p10), .p11(p11),
        .p12(p12), .p13(p13), .p14(p14)
    );

    //STAGE 4: Interpolation
    TOOM_8_Interpolation u_interpolation (
        .p0(p0), .p1(p1), .p2(p2), 
        .p3(p3), .p4(p4), .p5(p5),
        .p6(p6), .p7(p7), .p8(p8), 
        .p9(p9), .p10(p10), .p11(p11),
        .p12(p12), .p13(p13), .p14(p14),
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

    //STAGE 5: Recomposition
    TOOM_8_Recomposition u_recomposition (
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
        .c14_scaled(c14_scaled),
        .final_value(final_value_scaled)
    );

    
    always @(posedge clk) 
    begin
        if (!reset_n)
            product <= 0;

        else
            product <= $signed(final_value_scaled);
    end

endmodule
