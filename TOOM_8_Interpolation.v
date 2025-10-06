`timescale 1ns / 1ps
`include "constants_scaled_coefficients.vh"

module TOOM_8_Interpolation(
    input signed [257:0] p0,   
    input signed [263:0] p1, p2,  
    input signed [277:0] p3, p4,  
    input signed [287:0] p5, p6,  
    input signed [295:0] p7, p8,  
    input signed [297:0] p9, p10, 
    input signed [299:0] p11, p12, 
    input signed [309:0] p13,
    input signed [257:0] p14,
    
    output signed [290:0]  c0_scaled,
    output signed [363:0]  c1_scaled,
    output signed [359:0]  c2_scaled,
    output signed [368:0]  c3_scaled,
    output signed [353:0]  c4_scaled,
    output signed [364:0]  c5_scaled,
    output signed [351:0]  c6_scaled,
    output signed [349:0]  c7_scaled,
    output signed [338:0]  c8_scaled,
    output signed [333:0]  c9_scaled,
    output signed [329:0]  c10_scaled,
    output signed [319:0]  c11_scaled,
    output signed [309:0]  c12_scaled,
    output signed [295:0]  c13_scaled,
    output signed [291:0]  c14_scaled
    );
    
    
    //c0_scaled
    assign c0_scaled  = 34'd6227020800  * p0;

    //c1_scaled
    wire signed [383:0] c1_term0  = C1_0  * p0;
    wire signed [383:0] c1_term1  = C1_1  * p1;
    wire signed [383:0] c1_term2  = C1_2  * p2;
    wire signed [383:0] c1_term3  = C1_3  * p3;
    wire signed [383:0] c1_term4  = C1_4  * p4;
    wire signed [383:0] c1_term5  = C1_5  * p5;
    wire signed [383:0] c1_term6  = C1_6  * p6;
    wire signed [383:0] c1_term7  = C1_7  * p7;
    wire signed [383:0] c1_term8  = C1_8  * p8;
    wire signed [383:0] c1_term9  = C1_9  * p9;
    wire signed [383:0] c1_term10 = C1_10 * p10;
    wire signed [383:0] c1_term11 = C1_11 * p11;
    wire signed [383:0] c1_term12 = C1_12 * p12;
    wire signed [383:0] c1_term13 = C1_13 * p13;
    wire signed [383:0] c1_term14 = C1_14 * p14;

    assign c1_scaled = c1_term0 + c1_term1 + c1_term2 + c1_term3 +
                       c1_term4 + c1_term5 + c1_term6 + c1_term7 +
                       c1_term8 + c1_term9 + c1_term10+ c1_term11+
                       c1_term12+ c1_term13+ c1_term14;

    //c2_scaled
    wire signed [383:0] c2_term0  = C2_0  * p0;
    wire signed [383:0] c2_term1  = C2_1  * p1;
    wire signed [383:0] c2_term2  = C2_2  * p2;
    wire signed [383:0] c2_term3  = C2_3  * p3;
    wire signed [383:0] c2_term4  = C2_4  * p4;
    wire signed [383:0] c2_term5  = C2_5  * p5;
    wire signed [383:0] c2_term6  = C2_6  * p6;
    wire signed [383:0] c2_term7  = C2_7  * p7;
    wire signed [383:0] c2_term8  = C2_8  * p8;
    wire signed [383:0] c2_term9  = C2_9  * p9;
    wire signed [383:0] c2_term10 = C2_10 * p10;
    wire signed [383:0] c2_term11 = C2_11 * p11;
    wire signed [383:0] c2_term12 = C2_12 * p12;
    wire signed [383:0] c2_term14 = C2_14 * p14;

    assign c2_scaled = c2_term0 + c2_term1 + c2_term2 + c2_term3 + c2_term4 +
                       c2_term5 + c2_term6 + c2_term7 + c2_term8 + c2_term9 +
                       c2_term10+ c2_term11+ c2_term12+ c2_term14;

   //c3_scaled
    wire signed [383:0] c3_term0  = C3_0  * p0;
    wire signed [383:0] c3_term1  = C3_1  * p1;
    wire signed [383:0] c3_term2  = C3_2  * p2;
    wire signed [383:0] c3_term3  = C3_3  * p3;
    wire signed [383:0] c3_term4  = C3_4  * p4;
    wire signed [383:0] c3_term5  = C3_5  * p5;
    wire signed [383:0] c3_term6  = C3_6  * p6;
    wire signed [383:0] c3_term7  = C3_7  * p7;
    wire signed [383:0] c3_term8  = C3_8  * p8;
    wire signed [383:0] c3_term9  = C3_9  * p9;
    wire signed [383:0] c3_term10 = C3_10 * p10;
    wire signed [383:0] c3_term11 = C3_11 * p11;
    wire signed [383:0] c3_term12 = C3_12 * p12;
    wire signed [383:0] c3_term13 = C3_13 * p13;
    wire signed [383:0] c3_term14 = C3_14 * p14;

    assign c3_scaled = c3_term0 + c3_term1 + c3_term2 + c3_term3 + c3_term4 +
                       c3_term5 + c3_term6 + c3_term7 + c3_term8 + c3_term9 +
                       c3_term10+ c3_term11+ c3_term12+ c3_term13+ c3_term14;

   //c4_scaled
    wire signed [383:0] c4_term0  = C4_0  * p0;
    wire signed [383:0] c4_term1  = C4_1  * p1;
    wire signed [383:0] c4_term2  = C4_2  * p2;
    wire signed [383:0] c4_term3  = C4_3  * p3;
    wire signed [383:0] c4_term4  = C4_4  * p4;
    wire signed [383:0] c4_term5  = C4_5  * p5;
    wire signed [383:0] c4_term6  = C4_6  * p6;
    wire signed [383:0] c4_term7  = C4_7  * p7;
    wire signed [383:0] c4_term8  = C4_8  * p8;
    wire signed [383:0] c4_term9  = C4_9  * p9;
    wire signed [383:0] c4_term10 = C4_10 * p10;
    wire signed [383:0] c4_term11 = C4_11 * p11;
    wire signed [383:0] c4_term12 = C4_12 * p12;
    wire signed [383:0] c4_term14 = C4_14 * p14;

    assign c4_scaled = c4_term0 + c4_term1 + c4_term2 + c4_term3 + c4_term4 +
                       c4_term5 + c4_term6 + c4_term7 + c4_term8 + c4_term9 +
                       c4_term10+ c4_term11+ c4_term12+ c4_term14;

    //c5_scaled
    wire signed [383:0] c5_term0  = C5_0  * p0;
    wire signed [383:0] c5_term1  = C5_1  * p1;
    wire signed [383:0] c5_term2  = C5_2  * p2;
    wire signed [383:0] c5_term3  = C5_3  * p3;
    wire signed [383:0] c5_term4  = C5_4  * p4;
    wire signed [383:0] c5_term5  = C5_5  * p5;
    wire signed [383:0] c5_term6  = C5_6  * p6;
    wire signed [383:0] c5_term7  = C5_7  * p7;
    wire signed [383:0] c5_term8  = C5_8  * p8;
    wire signed [383:0] c5_term9  = C5_9  * p9;
    wire signed [383:0] c5_term10 = C5_10 * p10;
    wire signed [383:0] c5_term11 = C5_11 * p11;
    wire signed [383:0] c5_term12 = C5_12 * p12;
    wire signed [383:0] c5_term13 = C5_13 * p13;
    wire signed [383:0] c5_term14 = C5_14 * p14;

    assign c5_scaled = c5_term0 + c5_term1 + c5_term2 + c5_term3 + c5_term4 +
                       c5_term5 + c5_term6 + c5_term7 + c5_term8 + c5_term9 +
                       c5_term10+ c5_term11+ c5_term12+ c5_term13+ c5_term14;

    //c6_scaled
    wire signed [383:0] c6_term0  = C6_0  * p0;
    wire signed [383:0] c6_term1  = C6_1  * p1;
    wire signed [383:0] c6_term2  = C6_2  * p2;
    wire signed [383:0] c6_term3  = C6_3  * p3;
    wire signed [383:0] c6_term4  = C6_4  * p4;
    wire signed [383:0] c6_term5  = C6_5  * p5;
    wire signed [383:0] c6_term6  = C6_6  * p6;
    wire signed [383:0] c6_term7  = C6_7  * p7;
    wire signed [383:0] c6_term8  = C6_8  * p8;
    wire signed [383:0] c6_term9  = C6_9  * p9;
    wire signed [383:0] c6_term10 = C6_10 * p10;
    wire signed [383:0] c6_term11 = C6_11 * p11;
    wire signed [383:0] c6_term12 = C6_12 * p12;
    wire signed [383:0] c6_term14 = C6_14 * p14;

    assign c6_scaled = c6_term0 + c6_term1 + c6_term2 + c6_term3 + c6_term4 +
                       c6_term5 + c6_term6 + c6_term7 + c6_term8 + c6_term9 +
                       c6_term10+ c6_term11+ c6_term12+ c6_term14;

    //c7_scaled
    wire signed [383:0] c7_term0  = C7_0  * p0;
    wire signed [383:0] c7_term1  = C7_1  * p1;
    wire signed [383:0] c7_term2  = C7_2  * p2;
    wire signed [383:0] c7_term3  = C7_3  * p3;
    wire signed [383:0] c7_term4  = C7_4  * p4;
    wire signed [383:0] c7_term5  = C7_5  * p5;
    wire signed [383:0] c7_term6  = C7_6  * p6;
    wire signed [383:0] c7_term7  = C7_7  * p7;
    wire signed [383:0] c7_term8  = C7_8  * p8;
    wire signed [383:0] c7_term9  = C7_9  * p9;
    wire signed [383:0] c7_term10 = C7_10 * p10;
    wire signed [383:0] c7_term11 = C7_11 * p11;
    wire signed [383:0] c7_term12 = C7_12 * p12;
    wire signed [383:0] c7_term13 = C7_13 * p13;
    wire signed [383:0] c7_term14 = C7_14 * p14;

    assign c7_scaled = c7_term0 + c7_term1 + c7_term2 + c7_term3 + c7_term4 +
                       c7_term5 + c7_term6 + c7_term7 + c7_term8 + c7_term9 +
                       c7_term10+ c7_term11+ c7_term12+ c7_term13+ c7_term14;

    //c8_scaled
    wire signed [383:0] c8_term0  = C8_0  * p0;
    wire signed [383:0] c8_term1  = C8_1  * p1;
    wire signed [383:0] c8_term2  = C8_2  * p2;
    wire signed [383:0] c8_term3  = C8_3  * p3;
    wire signed [383:0] c8_term4  = C8_4  * p4;
    wire signed [383:0] c8_term5  = C8_5  * p5;
    wire signed [383:0] c8_term6  = C8_6  * p6;
    wire signed [383:0] c8_term7  = C8_7  * p7;
    wire signed [383:0] c8_term8  = C8_8  * p8;
    wire signed [383:0] c8_term9  = C8_9  * p9;
    wire signed [383:0] c8_term10 = C8_10 * p10;
    wire signed [383:0] c8_term11 = C8_11 * p11;
    wire signed [383:0] c8_term12 = C8_12 * p12;
    wire signed [383:0] c8_term14 = C8_14 * p14;

    assign c8_scaled = c8_term0 + c8_term1 + c8_term2 + c8_term3 + c8_term4 +
                       c8_term5 + c8_term6 + c8_term7 + c8_term8 + c8_term9 +
                       c8_term10+ c8_term11+ c8_term12+ c8_term14;

    //c9_scaled
    wire signed [383:0] c9_term0  = C9_0  * p0;
    wire signed [383:0] c9_term1  = C9_1  * p1;
    wire signed [383:0] c9_term2  = C9_2  * p2;
    wire signed [383:0] c9_term3  = C9_3  * p3;
    wire signed [383:0] c9_term4  = C9_4  * p4;
    wire signed [383:0] c9_term5  = C9_5  * p5;
    wire signed [383:0] c9_term6  = C9_6  * p6;
    wire signed [383:0] c9_term7  = C9_7  * p7;
    wire signed [383:0] c9_term8  = C9_8  * p8;
    wire signed [383:0] c9_term9  = C9_9  * p9;
    wire signed [383:0] c9_term10 = C9_10 * p10;
    wire signed [383:0] c9_term11 = C9_11 * p11;
    wire signed [383:0] c9_term12 = C9_12 * p12;
    wire signed [383:0] c9_term13 = C9_13 * p13;
    wire signed [383:0] c9_term14 = C9_14 * p14;

    assign c9_scaled = c9_term0 + c9_term1 + c9_term2 + c9_term3 + c9_term4 +
                       c9_term5 + c9_term6 + c9_term7 + c9_term8 + c9_term9 +
                       c9_term10+ c9_term11+ c9_term12+ c9_term13+ c9_term14;

    //c10_scaled
    wire signed [383:0] c10_term0  = C10_0  * p0;
    wire signed [383:0] c10_term1  = C10_1  * p1;
    wire signed [383:0] c10_term2  = C10_2  * p2;
    wire signed [383:0] c10_term3  = C10_3  * p3;
    wire signed [383:0] c10_term4  = C10_4  * p4;
    wire signed [383:0] c10_term5  = C10_5  * p5;
    wire signed [383:0] c10_term6  = C10_6  * p6;
    wire signed [383:0] c10_term7  = C10_7  * p7;
    wire signed [383:0] c10_term8  = C10_8  * p8;
    wire signed [383:0] c10_term9  = C10_9  * p9;
    wire signed [383:0] c10_term10 = C10_10 * p10;
    wire signed [383:0] c10_term11 = C10_11 * p11;
    wire signed [383:0] c10_term12 = C10_12 * p12;
    wire signed [383:0] c10_term14 = C10_14 * p14;

    assign c10_scaled = c10_term0 + c10_term1 + c10_term2 + c10_term3 + c10_term4 +
                        c10_term5 + c10_term6 + c10_term7 + c10_term8 + c10_term9 +
                        c10_term10+ c10_term11+ c10_term12+ c10_term14;

    //c11_scaled
    wire signed [383:0] c11_term0  = C11_0  * p0;
    wire signed [383:0] c11_term1  = C11_1  * p1;
    wire signed [383:0] c11_term2  = C11_2  * p2;
    wire signed [383:0] c11_term3  = C11_3  * p3;
    wire signed [383:0] c11_term4  = C11_4  * p4;
    wire signed [383:0] c11_term5  = C11_5  * p5;
    wire signed [383:0] c11_term6  = C11_6  * p6;
    wire signed [383:0] c11_term7  = C11_7  * p7;
    wire signed [383:0] c11_term8  = C11_8  * p8;
    wire signed [383:0] c11_term9  = C11_9  * p9;
    wire signed [383:0] c11_term10 = C11_10 * p10;
    wire signed [383:0] c11_term11 = C11_11 * p11;
    wire signed [383:0] c11_term12 = C11_12 * p12;
    wire signed [383:0] c11_term13 = C11_13 * p13;
    wire signed [383:0] c11_term14 = C11_14 * p14;

    assign c11_scaled = c11_term0 + c11_term1 + c11_term2 + c11_term3 + c11_term4 +
                        c11_term5 + c11_term6 + c11_term7 + c11_term8 + c11_term9 +
                        c11_term10+ c11_term11+ c11_term12+ c11_term13+ c11_term14;

    //c12_scaled
    wire signed [383:0] c12_term0  = C12_0  * p0;
    wire signed [383:0] c12_term1  = C12_1  * p1;
    wire signed [383:0] c12_term2  = C12_2  * p2;
    wire signed [383:0] c12_term3  = C12_3  * p3;
    wire signed [383:0] c12_term4  = C12_4  * p4;
    wire signed [383:0] c12_term5  = C12_5  * p5;
    wire signed [383:0] c12_term6  = C12_6  * p6;
    wire signed [383:0] c12_term7  = C12_7  * p7;
    wire signed [383:0] c12_term8  = C12_8  * p8;
    wire signed [383:0] c12_term9  = C12_9  * p9;
    wire signed [383:0] c12_term10 = C12_10 * p10;
    wire signed [383:0] c12_term11 = C12_11 * p11;
    wire signed [383:0] c12_term12 = C12_12 * p12;
    wire signed [383:0] c12_term14 = C12_14 * p14;
    
    assign c12_scaled = c12_term0 + c12_term1 + c12_term2 + c12_term3 + c12_term4 +
                        c12_term5 + c12_term6 + c12_term7 + c12_term8 + c12_term9 +
                        c12_term10+ c12_term11+ c12_term12+ c12_term14;

    //c13_scaled
    wire signed [383:0] c13_term0  = C13_0  * p0;
    wire signed [383:0] c13_term1  = C13_1  * p1;
    wire signed [383:0] c13_term2  = C13_2  * p2;
    wire signed [383:0] c13_term3  = C13_3  * p3;
    wire signed [383:0] c13_term4  = C13_4  * p4;
    wire signed [383:0] c13_term5  = C13_5  * p5;
    wire signed [383:0] c13_term6  = C13_6  * p6;
    wire signed [383:0] c13_term7  = C13_7  * p7;
    wire signed [383:0] c13_term8  = C13_8  * p8;
    wire signed [383:0] c13_term9  = C13_9  * p9;
    wire signed [383:0] c13_term10 = C13_10 * p10;
    wire signed [383:0] c13_term11 = C13_11 * p11;
    wire signed [383:0] c13_term12 = C13_12 * p12;
    wire signed [383:0] c13_term13 = C13_13 * p13;
    wire signed [383:0] c13_term14 = C13_14 * p14;

    assign c13_scaled = c13_term0 + c13_term1 + c13_term2 + c13_term3 + c13_term4 +
                        c13_term5 + c13_term6 + c13_term7 + c13_term8 + c13_term9 +
                        c13_term10+ c13_term11+ c13_term12+ c13_term13+ c13_term14;

    //c14_scaled
    assign c14_scaled = 43'd6227020800 * p14;

endmodule
