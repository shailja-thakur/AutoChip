module top_module (
    input [7:0] in,
    output [31:0] out );//

    // Insert your code below
    // assign out = { replicate-sign-bit , the-input };

    assign out = { (in[7] & 1) << 24, in };

endmodule