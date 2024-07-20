module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

// Create internal wire for the sel bits
wire [7:0] sel_bits;

// Generate the individual select signals for each group of 4 bits
assign sel_bits = sel * 4;

// Create internal wire for the selected bits
wire [3:0] selected_bits;

// Extract the desired bits based on the select signals
assign selected_bits = in[sel_bits +: 4];

// Assign the output
assign out = selected_bits;

endmodule
