module top_module (
    input [7:0] in,
    output [31:0] out
);

    // Sign-extend the 8-bit input to a 32-bit output
    assign out = {{24{in[7]}}, in};

endmodule
