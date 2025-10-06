`timescale 1ns / 1ps

module TOOM_8_Splitting_TB;

    reg clk;
    reg [1023:0] A, B;
    wire [2047:0] product;

    wire [128:0] A_chunk0_out, A_chunk1_out, A_chunk2_out, A_chunk3_out,
                 A_chunk4_out, A_chunk5_out, A_chunk6_out, A_chunk7_out;
    wire [128:0] B_chunk0_out, B_chunk1_out, B_chunk2_out, B_chunk3_out,
                 B_chunk4_out, B_chunk5_out, B_chunk6_out, B_chunk7_out;

    // DUT instantiation
    TOOM_8_Splitting DUT (
        .clk(clk),
        .X(A),
        .Y(B),
        .product(product),
        .A_chunk0(A_chunk0_out), .A_chunk1(A_chunk1_out),
        .A_chunk2(A_chunk2_out), .A_chunk3(A_chunk3_out),
        .A_chunk4(A_chunk4_out), .A_chunk5(A_chunk5_out),
        .A_chunk6(A_chunk6_out), .A_chunk7(A_chunk7_out),

        .B_chunk0(B_chunk0_out), .B_chunk1(B_chunk1_out),
        .B_chunk2(B_chunk2_out), .B_chunk3(B_chunk3_out),
        .B_chunk4(B_chunk4_out), .B_chunk5(B_chunk5_out),
        .B_chunk6(B_chunk6_out), .B_chunk7(B_chunk7_out)
    );

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Task to display chunks
    task show_chunks;
        input [1023:0] val;
        input [8*10:1] name;
        begin
            $display("%s Chunks:", name);
            $display("  Chunk0=%h", DUT.A_chunk0);
            $display("  Chunk1=%h", DUT.A_chunk1);
            $display("  Chunk2=%h", DUT.A_chunk2);
            $display("  Chunk3=%h", DUT.A_chunk3);
            $display("  Chunk4=%h", DUT.A_chunk4);
            $display("  Chunk5=%h", DUT.A_chunk5);
            $display("  Chunk6=%h", DUT.A_chunk6);
            $display("  Chunk7=%h", DUT.A_chunk7);
            $display("-----------------------------");
        end
    endtask

    // Stimulus
    initial begin
        A = 0; B = 0;

        // Test 1: signed numbers
        @(posedge clk);
        // Mix of positive and negative 128-bit chunks (MSB = 1 means negative)
        A = 1024'h80000000000000000000000000000001_7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF_80000000000000000000000000000002_7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE_80000000000000000000000000000003_7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD_80000000000000000000000000000004_7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC;
        B = 1024'h7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF_80000000000000000000000000000001_7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE_80000000000000000000000000000002_7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD_80000000000000000000000000000003_7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC_80000000000000000000000000000004;

        @(posedge clk);
        show_chunks(A, "A_signed");
        show_chunks(B, "B_signed");

        #50;
        $display("Signed-number test finished.");
        $finish;
    end

endmodule
