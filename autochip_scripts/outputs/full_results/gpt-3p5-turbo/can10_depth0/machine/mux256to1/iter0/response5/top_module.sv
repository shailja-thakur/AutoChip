module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

wire [7:0] sel_valid;

// Check if sel is within range
assign sel_valid = (sel < 256);

// Output is the bit selected from input vector based on sel
assign out = in[sel];

endmodule
