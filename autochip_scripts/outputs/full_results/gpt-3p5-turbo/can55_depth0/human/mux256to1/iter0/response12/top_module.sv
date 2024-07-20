module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

// Create a 256-to-1 multiplexer
wire [255:0] mux_output;
assign mux_output = sel < 256 ? in[sel] : 0;

// Output the selected input from the multiplexer
assign out = mux_output;

endmodule
