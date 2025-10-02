
`timescale 1ns/1ps

module TOOM_8 (
    input  clk,
    input  [1023:0] X,
    input  [1023:0] Y,
    output reg [2047:0] product,
    
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

 
    assign A_chunk0 = {1'b0, A[127:0]};
    assign A_chunk1 = {1'b0, A[255:128]};
    assign A_chunk2 = {1'b0, A[383:256]};
    assign A_chunk3 = {1'b0, A[511:384]};
    assign A_chunk4 = {1'b0, A[639:512]};
    assign A_chunk5 = {1'b0, A[767:640]};
    assign A_chunk6 = {1'b0, A[895:768]};
    assign A_chunk7 = {1'b0, A[1023:896]};

    assign B_chunk0 = {1'b0, B[127:0]};
    assign B_chunk1 = {1'b0, B[255:128]};
    assign B_chunk2 = {1'b0, B[383:256]};
    assign B_chunk3 = {1'b0, B[511:384]};
    assign B_chunk4 = {1'b0, B[639:512]};
    assign B_chunk5 = {1'b0, B[767:640]};
    assign B_chunk6 = {1'b0, B[895:768]};
    assign B_chunk7 = {1'b0, B[1023:896]};

     //for evaluation point 0 
     wire signed [128:0] a0 = A_chunk0;
     wire signed [128:0] b0 = B_chunk0;
     
     //for evaluation point 1 and -1
     wire signed [131:0] a1 = A_chunk0 + A_chunk1 + A_chunk2 + A_chunk3 + A_chunk4 + A_chunk5 + A_chunk6 + A_chunk7;
     wire signed [131:0] a2 = A_chunk0 - A_chunk1 + A_chunk2 - A_chunk3 + A_chunk4 - A_chunk5 + A_chunk6 - A_chunk7;
     
     wire signed [131:0] b1  = B_chunk0 + B_chunk1 + B_chunk2 + B_chunk3 + B_chunk4 + B_chunk5 + B_chunk6 + B_chunk7;
     wire signed [131:0] b2  = B_chunk0 - B_chunk1 + B_chunk2 - B_chunk3 + B_chunk4 - B_chunk5 + B_chunk6 - B_chunk7;
     
     //for evaluation point 2 and -2
     wire signed [138:0] a3 = A_chunk0 + (A_chunk1<<<1) + (A_chunk2<<<2) + (A_chunk3<<<3) + (A_chunk4<<<4) + (A_chunk5<<<5) + (A_chunk6<<<6) + (A_chunk7<<<7);
     wire signed [138:0] a4 = A_chunk0 - (A_chunk1<<<1) + (A_chunk2<<<2) - (A_chunk3<<<3) + (A_chunk4<<<4) - (A_chunk5<<<5) + (A_chunk6<<<6) - (A_chunk7<<<7);
    
     wire signed [138:0] b3  = B_chunk0 + (B_chunk1<<<1) + (B_chunk2<<<2) + (B_chunk3<<<3) + (B_chunk4<<<4) + (B_chunk5<<<5) + (B_chunk6<<<6) + (B_chunk7<<<7);
     wire signed [138:0] b4  = B_chunk0 - (B_chunk1<<<1) + (B_chunk2<<<2) - (B_chunk3<<<3) + (B_chunk4<<<4) - (B_chunk5<<<5) + (B_chunk6<<<6) - (B_chunk7<<<7);
     
     //for evaluation point 3 and -3
     wire signed [143:0] a5 = A_chunk0 + ((A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 3) + A_chunk2) + ((A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 6) + (A_chunk4 <<< 4) + A_chunk4) + ((A_chunk5 <<< 7) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 9) + (A_chunk6 <<< 7) + (A_chunk6 <<< 6) + (A_chunk6 <<< 4) + (A_chunk6 <<< 3) + A_chunk6) + ( (A_chunk7 <<< 11) + (A_chunk7 <<< 7) + (A_chunk7 <<< 3) + (A_chunk7 <<< 1) + A_chunk7);                       
     wire signed [143:0] a6 = A_chunk0 - ((A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 3) + A_chunk2) - ((A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 6) + (A_chunk4 <<< 4) + A_chunk4) - ((A_chunk5 <<< 7) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 9) + (A_chunk6 <<< 7) + (A_chunk6 <<< 6) + (A_chunk6 <<< 4) + (A_chunk6 <<< 3) + A_chunk6) - ( (A_chunk7 <<< 11) + (A_chunk7 <<< 7) + (A_chunk7 <<< 3) + (A_chunk7 <<< 1) + A_chunk7);
     
    
     wire signed [143:0] b5  = B_chunk0 + ((B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 3) + B_chunk2) + ((B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 6) + (B_chunk4 <<< 4) + B_chunk4) + ((B_chunk5 <<< 7) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 9) + (B_chunk6 <<< 7) + (B_chunk6 <<< 6) + (B_chunk6 <<< 4) + (B_chunk6 <<< 3) + B_chunk6) + ( (B_chunk7 <<< 11) + (B_chunk7 <<< 7) + (B_chunk7 <<< 3) + (B_chunk7 <<< 1) + B_chunk7);                       
     wire signed [143:0] b6  = B_chunk0 - ((B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 3) + B_chunk2) - ((B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 6) + (B_chunk4 <<< 4) + B_chunk4) - ((B_chunk5 <<< 7) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 9) + (B_chunk6 <<< 7) + (B_chunk6 <<< 6) + (B_chunk6 <<< 4) + (B_chunk6 <<< 3) + B_chunk6) - ( (B_chunk7 <<< 11) + (B_chunk7 <<< 7) + (B_chunk7 <<< 3) + (B_chunk7 <<< 1) + B_chunk7);
     
     //for evaluation point 4 and -4
     wire signed [145:0] a7 = A_chunk0 + (A_chunk1<<<2) + (A_chunk2<<<4) + (A_chunk3<<<6) + (A_chunk4<<<8) + (A_chunk5<<<10) + (A_chunk6<<<12) + (A_chunk7<<<14);
     wire signed [145:0] a8 = A_chunk0 - (A_chunk1<<<2) + (A_chunk2<<<4) - (A_chunk3<<<6) + (A_chunk4<<<8) - (A_chunk5<<<10) + (A_chunk6<<<12) - (A_chunk7<<<14);
     
     wire signed [145:0] b7  = B_chunk0 + (B_chunk1<<<2) + (B_chunk2<<<4) + (B_chunk3<<<6) + (B_chunk4<<<8) + (B_chunk5<<<10) + (B_chunk6<<<12) + (B_chunk7<<<14);
     wire signed [145:0] b8  = B_chunk0 - (B_chunk1<<<2) + (B_chunk2<<<4) - (B_chunk3<<<6) + (B_chunk4<<<8) - (B_chunk5<<<10) + (B_chunk6<<<12) - (B_chunk7<<<14);
     
     //for evaluation point 5 and -5
     wire signed [148:0] a9 = A_chunk0 + ((A_chunk1 <<< 2) + A_chunk1) + ((A_chunk2 <<< 4) + (A_chunk2 <<< 3) + A_chunk2) + ((A_chunk3 <<< 6) + (A_chunk3 <<< 5) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 2) + A_chunk3) + ((A_chunk4 <<< 9) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + (A_chunk4 <<< 4) + A_chunk4) + ((A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 2) + A_chunk5) + ((A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 11) + (A_chunk6 <<< 8) + (A_chunk6 <<< 3) + A_chunk6) + ((A_chunk7 <<< 16) + (A_chunk7 <<< 13) + (A_chunk7 <<< 12) + (A_chunk7 <<< 8) + (A_chunk7 <<< 5) + (A_chunk7 <<< 3) + (A_chunk7 <<< 2) + A_chunk7);  
     wire signed [148:0] a10 = A_chunk0 - ((A_chunk1 <<< 2) + A_chunk1) + ((A_chunk2 <<< 4) + (A_chunk2 <<< 3) + A_chunk2) - ((A_chunk3 <<< 6) + (A_chunk3 <<< 5) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3) + (A_chunk3 <<< 2) + A_chunk3) + ((A_chunk4 <<< 9) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + (A_chunk4 <<< 4) + A_chunk4) - ((A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 5) + (A_chunk5 <<< 4) + (A_chunk5 <<< 2) + A_chunk5) + ((A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 11) + (A_chunk6 <<< 8) + (A_chunk6 <<< 3) + A_chunk6) + ((A_chunk7 <<< 16) - (A_chunk7 <<< 13) + (A_chunk7 <<< 12) + (A_chunk7 <<< 8) + (A_chunk7 <<< 5) + (A_chunk7 <<< 3) + (A_chunk7 <<< 2) + A_chunk7);  
    
     wire signed [148:0] b9 = B_chunk0 + ((B_chunk1 <<< 2) + B_chunk1) + ((B_chunk2 <<< 4) + (B_chunk2 <<< 3) + B_chunk2) + ((B_chunk3 <<< 6) + (B_chunk3 <<< 5) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 2) + B_chunk3) + ((B_chunk4 <<< 9) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + (B_chunk4 <<< 4) + B_chunk4) + ((B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 2) + B_chunk5) + ((B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 11) + (B_chunk6 <<< 8) + (B_chunk6 <<< 3) + B_chunk6) + ((B_chunk7 <<< 16) + (B_chunk7 <<< 13) + (B_chunk7 <<< 12) + (B_chunk7 <<< 8) + (B_chunk7 <<< 5) + (B_chunk7 <<< 3) + (B_chunk7 <<< 2) + B_chunk7);  
     wire signed [148:0] b10 = B_chunk0 - ((B_chunk1 <<< 2) + B_chunk1) + ((B_chunk2 <<< 4) + (B_chunk2 <<< 3) + B_chunk2) - ((B_chunk3 <<< 6) + (B_chunk3 <<< 5) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3) + (B_chunk3 <<< 2) + B_chunk3) + ((B_chunk4 <<< 9) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + (B_chunk4 <<< 4) + B_chunk4) - ((B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 5) + (B_chunk5 <<< 4) + (B_chunk5 <<< 2) + B_chunk5) + ((B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 11) + (B_chunk6 <<< 8) + (B_chunk6 <<< 3) + B_chunk6) + ((B_chunk7 <<< 16) - (B_chunk7 <<< 13) + (B_chunk7 <<< 12) + (B_chunk7 <<< 8) + (B_chunk7 <<< 5) + (B_chunk7 <<< 3) + (B_chunk7 <<< 2) + B_chunk7);  
     
     //for evaluation point 6 and -6
     wire signed [149:0] a11 = A_chunk0 + ((A_chunk1 <<< 2) + (A_chunk1 <<< 1)) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 2)) + ((A_chunk3 <<< 7) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3)) + ((A_chunk4 <<< 10) + (A_chunk4 <<< 8) + (A_chunk4 <<< 4)) + ((A_chunk5 <<< 12) + (A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 9) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5)) + ((A_chunk6 <<< 15) + (A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 10) + (A_chunk6 <<< 9) + (A_chunk6 <<< 6)) + ((A_chunk7 <<< 18) + (A_chunk7 <<< 14) + (A_chunk7 <<< 10) + (A_chunk7 <<< 8) + (A_chunk7 <<< 7));
     wire signed [149:0] a12 = A_chunk0 - ((A_chunk1 <<< 2) + (A_chunk1 <<< 1)) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 2)) - ((A_chunk3 <<< 7) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 3)) + ((A_chunk4 <<< 10) + (A_chunk4 <<< 8) + (A_chunk4 <<< 4)) - ((A_chunk5 <<< 12) + (A_chunk5 <<< 11) + (A_chunk5 <<< 10) + (A_chunk5 <<< 9) + (A_chunk5 <<< 6) + (A_chunk5 <<< 5)) + ((A_chunk6 <<< 15) + (A_chunk6 <<< 13) + (A_chunk6 <<< 12) + (A_chunk6 <<< 10) + (A_chunk6 <<< 9) + (A_chunk6 <<< 6)) - ((A_chunk7 <<< 18) + (A_chunk7 <<< 14) + (A_chunk7 <<< 10) + (A_chunk7 <<< 8) + (A_chunk7 <<< 7));                                 
    
     wire signed [149:0] b11 = B_chunk0 + ((B_chunk1 <<< 2) + (B_chunk1 <<< 1)) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 2)) + ((B_chunk3 <<< 7) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3)) + ((B_chunk4 <<< 10) + (B_chunk4 <<< 8) + (B_chunk4 <<< 4)) + ((B_chunk5 <<< 12) + (B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 9) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5)) + ((B_chunk6 <<< 15) + (B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 10) + (B_chunk6 <<< 9) + (B_chunk6 <<< 6)) + ((B_chunk7 <<< 18) + (B_chunk7 <<< 14) + (B_chunk7 <<< 10) + (B_chunk7 <<< 8) + (B_chunk7 <<< 7));
     wire signed [149:0] b12 = B_chunk0 - ((B_chunk1 <<< 2) + (B_chunk1 <<< 1)) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 2)) - ((B_chunk3 <<< 7) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 3)) + ((B_chunk4 <<< 10) + (B_chunk4 <<< 8) + (B_chunk4 <<< 4)) - ((B_chunk5 <<< 12) + (B_chunk5 <<< 11) + (B_chunk5 <<< 10) + (B_chunk5 <<< 9) + (B_chunk5 <<< 6) + (B_chunk5 <<< 5)) + ((B_chunk6 <<< 15) + (B_chunk6 <<< 13) + (B_chunk6 <<< 12) + (B_chunk6 <<< 10) + (B_chunk6 <<< 9) + (B_chunk6 <<< 6)) - ((B_chunk7 <<< 18) + (B_chunk7 <<< 14) + (B_chunk7 <<< 10) + (B_chunk7 <<< 8) + (B_chunk7 <<< 7));   
     
     //for evaluation poinr -7
     wire signed [154:0] a13 = A_chunk0 - ((A_chunk1 <<< 2) + (A_chunk1 <<< 1) + A_chunk1) + ((A_chunk2 <<< 5) + (A_chunk2 <<< 4) + A_chunk2) - ((A_chunk3 <<< 8) + (A_chunk3 <<< 6) + (A_chunk3 <<< 4) + (A_chunk3 <<< 2) + (A_chunk3 <<< 1) + A_chunk3) + ((A_chunk4 <<< 11) + (A_chunk4 <<< 8) + (A_chunk4 <<< 6) + (A_chunk4 <<< 5) + A_chunk4) - ((A_chunk5 <<< 14) + (A_chunk5 <<< 8) + (A_chunk5 <<< 7) + (A_chunk5 <<< 5) + (A_chunk5 <<< 2) + (A_chunk5 <<< 1) + A_chunk5) + ((A_chunk6 <<< 16) + (A_chunk6 <<< 15) + (A_chunk6 <<< 14) + (A_chunk6 <<< 11) + (A_chunk6 <<< 9) + (A_chunk6 <<< 8) + (A_chunk6 <<< 7) + (A_chunk6 <<< 4) + A_chunk6) - ((A_chunk7 <<< 19) + (A_chunk7 <<< 18) + (A_chunk7 <<< 15) + (A_chunk7 <<< 12) + (A_chunk7 <<< 7) + (A_chunk7 <<< 6) + (A_chunk7 <<< 5) + (A_chunk7 <<< 4) + (A_chunk7 <<< 2) + (A_chunk7 <<< 1) + A_chunk7);              
     wire signed [154:0] b13 = B_chunk0 - ((B_chunk1 <<< 2) + (B_chunk1 <<< 1) + B_chunk1) + ((B_chunk2 <<< 5) + (B_chunk2 <<< 4) + B_chunk2) - ((B_chunk3 <<< 8) + (B_chunk3 <<< 6) + (B_chunk3 <<< 4) + (B_chunk3 <<< 2) + (B_chunk3 <<< 1) + B_chunk3) + ((B_chunk4 <<< 11) + (B_chunk4 <<< 8) + (B_chunk4 <<< 6) + (B_chunk4 <<< 5) + B_chunk4) - ((B_chunk5 <<< 14) + (B_chunk5 <<< 8) + (B_chunk5 <<< 7) + (B_chunk5 <<< 5) + (B_chunk5 <<< 2) + (B_chunk5 <<< 1) + B_chunk5) + ((B_chunk6 <<< 16) + (B_chunk6 <<< 15) + (B_chunk6 <<< 14) + (B_chunk6 <<< 11) + (B_chunk6 <<< 9) + (B_chunk6 <<< 8) + (B_chunk6 <<< 7) + (B_chunk6 <<< 4) + B_chunk6) - ((B_chunk7 <<< 19) + (B_chunk7 <<< 18) + (B_chunk7 <<< 15) + (B_chunk7 <<< 12) + (B_chunk7 <<< 7) + (B_chunk7 <<< 6) + (B_chunk7 <<< 5) + (B_chunk7 <<< 4) + (B_chunk7 <<< 2) + (B_chunk7 <<< 1) + B_chunk7);
     

     //for evaluation point inf
     wire signed [128:0] ainf = A_chunk7;
     wire signed [128:0] binf = B_chunk7;
     

     
    //pointwise multiplication
    wire signed [257:0] p0;    
    wire signed [263:0] p1, p2;  
    wire signed [277:0] p3, p4;  
    wire signed [287:0] p5, p6;  
    wire signed [295:0] p7, p8;  
    wire signed [297:0] p9, p10; 
    wire signed [299:0] p11, p12; 
    wire signed [309:0] p13;     
    wire signed [257:0] p14;

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
    
    //LCM Scaled coefficients
    /*wire signed [290:0]  c0_scaled;
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
    wire signed [291:0]  c14_scaled;*/

    //assignments
    assign c0_scaled  = 34'd6227020800  * p0;
    
    assign c1_scaled  = 30'd889574400   * p0 + 33'd4670265600  * p1 - 34'd6227020800  * p2 - 31'd1297296000 * p3
                      + 32'd2335132800  * p4 + 30'd345945600   * p5 - 31'd864864000   * p6 - 27'd70761600   * p7
                      + 29'd259459200   * p8 + 24'd9434880     * p9 - 26'd56609280    * p10 - 20'd604800    * p11
                      + 23'd7862400     * p12 - 19'd518400     * p13 + 55'd22596613079040000 * p14;

    assign c2_scaled  = 33'd5337446400  * p1 - 34'd9286909632  * p0 + 33'd5337446400  * p2 - 30'd833976000 * p3
                      - 30'd833976000   * p4 + 28'd164736000   * p5 + 28'd164736000   * p6 - 25'd27799200  * p7
                      - 25'd27799200    * p8 + 23'd3234816     * p9 + 23'd3234816     * p10 - 18'd187200   * p11
                      - 18'd187200      * p12 + 52'd3228087582720000 * p14;

    assign c3_scaled  = 32'd3949463232  * p2 - 31'd1627735824 * p1 - 31'd1326701376 * p0 + 31'd1517784840 * p3
                      - 32'd3065603112  * p4 - 30'd461027424  * p5 + 31'd1234936560 * p6 + 27'd98583264   * p7
                      - 30'd380004768   * p8 - 24'd13424112   * p9 + 27'd83779488   * p10 + 20'd870792    * p11
                      - 24'd11694696    * p12 + 20'd773136    * p13 - 55'd33700337672601600 * p14;

    assign c4_scaled  = 32'd3559107552  * p0 - 32'd2622761856 * p1 - 32'd2622761856 * p2 + 30'd1035288540 * p3
                      + 30'd1035288540  * p4 - 28'd227381440  * p5 - 28'd227381440  * p6 + 26'd39721968   * p7
                      + 26'd39721968    * p8 - 23'd4694976    * p9 - 23'd4694976    * p10 + 19'd273988    * p11
                      + 19'd273988      * p12 - 53'd4814333953228800 * p14;

    assign c5_scaled  = 29'd508443936   * p0 + 26'd46568808  * p1 - 30'd936345696   * p2 - 28'd223836470 * p3
                      + 30'd817021062   * p4 + 27'd121934384 * p5 - 29'd418526680   * p6 - 25'd30513912  * p7
                      + 28'd138365656   * p8 + 23'd4453592   * p9 - 27'd31416528    * p10 - 20'd300014   * p11
                      + 23'd4448158     * p12 - 19'd296296   * p13 + 54'd12915289484697600 * p14;

    assign c6_scaled  = 29'd427901760   * p1 - 30'd534209676 * p0 + 29'd427901760 * p2 - 28'd217844055 * p3
                      - 28'd217844055   * p4 + 27'd68891680  * p5 + 27'd68891680  * p6 - 24'd13406250  * p7
                      - 24'd13406250    * p8 + 21'd1661088   * p9 + 21'd1661088   * p10 - 17'd99385    * p11
                      - 17'd99385       * p12 + 51'd1845041354956800 * p14;

    assign c7_scaled  = 27'd27244503    * p1 - 27'd76315668  * p0 + 27'd106307916 * p2 + 24'd2371655 * p3
                      - 27'd91406601    * p4 - 24'd6714422   * p5 + 26'd51231895  * p6 + 24'd2719002 * p7
                      - 25'd18907174    * p8 - 21'd477191    * p9 + 23'd4524234   * p10 + 17'd35321  * p11
                      - 20'd657943      * p12 + 16'd44473    * p13 - 51'd1938540072268800 * p14;

    assign c8_scaled  = 26'd36072036    * p0 - 26'd29992248  * p1 - 26'd29992248 * p2 + 25'd17084925 * p3
                      + 25'd17084925    * p4 - 23'd6477900   * p5 - 23'd6477900  * p6 + 21'd1546974  * p7
                      + 21'd1546974     * p8 - 18'd211068    * p9 - 18'd211068   * p10 + 14'd13299   * p11
                      + 14'd13299       * p12 - 48'd276934296038400 * p14;

    assign c9_scaled  = 29'd5153148     * p0 - 23'd2938221  * p1 - 23'd6079788  * p2 + 21'd1027455 * p3
                      + 23'd4984551     * p4 - 18'd155298   * p5 - 23'd2850705  * p6 - 15'd23166   * p7
                      + 21'd1116258     * p8 + 14'd12441    * p9 - 19'd285714   * p10 - 12'd1287   * p11
                      + 16'd43329       * p12 - 12'd3003    * p13 + 47'd130898204236800 * p14;

    assign c10_scaled = 20'd926640     * p1 - 21'd1093092   * p0 + 20'd926640   * p2 - 20'd559845 * p3
                      - 20'd559845     * p4 + 19'd234520    * p5 + 19'd234520   * p6 - 17'd64350  * p7
                      - 17'd64350      * p8 + 14'd10296     * p9 + 14'd10296    * p10 - 10'd715   * p11
                      - 10'd715        * p12 + 45'd18699743462400 * p14;

    assign c11_scaled = 17'd106821     * p1 - 18'd156156   * p0 + 18'd166452   * p2 - 16'd52195 * p3
                      - 17'd129987     * p4 + 15'd17446    * p5 + 17'd73645    * p6 - 13'd3666  * p7
                      - 16'd29458      * p8 + 10'd403      * p9 + 14'd7878     * p10 - 5'd13    * p11
                      - 11'd1261       * p12 + 7'd91       * p13 - 42'd3966612249600 * p14;

    assign c12_scaled = 14'd12012      * p0 - 14'd10296     * p1 - 14'd10296  * p2 + 13'd6435 * p3
                      + 13'd6435       * p4 - 12'd2860      * p5 - 12'd2860   * p6 + 10'd858  * p7
                      + 10'd858        * p8 - 8'd156        * p9 - 8'd156     * p10 + 4'd13   * p11
                      + 4'd13          * p12 - 40'd566658892800 * p14;

    assign c13_scaled = 12'd1716       * p0 - 11'd1287     * p1 - 12'd1716  * p2 + 10'd715 * p3
                      + 11'd1287       * p4 - 9'd286       * p5 - 10'd715   * p6 + 7'd78   * p7
                      + 9'd286         * p8 - 4'd13        * p9 - 7'd78     * p10 + 1'd1   * p11
                      + 4'd13          * p12 - 1'd1        * p13 + 36'd43589145600 * p14;

    assign c14_scaled = 43'd6227020800 * p14;


    
endmodule
