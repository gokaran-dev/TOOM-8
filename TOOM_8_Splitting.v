`timescale 1ns/1ps

module TOOM_8_Splitting (
    input  clk,
    input  [1023:0] X,
    input  [1023:0] Y,
    output reg [2047:0] product,

    output [128:0] A_chunk0,
    output [128:0] A_chunk1,
    output [128:0] A_chunk2,
    output [128:0] A_chunk3,
    output [128:0] A_chunk4,
    output [128:0] A_chunk5,
    output [128:0] A_chunk6,
    output [128:0] A_chunk7,

    output [128:0] B_chunk0,
    output [128:0] B_chunk1,
    output [128:0] B_chunk2,
    output [128:0] B_chunk3,
    output [128:0] B_chunk4,
    output [128:0] B_chunk5,
    output [128:0] B_chunk6,
    output [128:0] B_chunk7
);

    
    reg [1023:0] A;
    reg [1023:0] B;
    wire [2047:0] final_value;

    always @(posedge clk) begin
        A <= X;
        B <= Y;
        product <= final_value;
    end

    //Manually assign chunks (with 1 leading zero to make 129 bits, so its compatible with sign operations)
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

endmodule
