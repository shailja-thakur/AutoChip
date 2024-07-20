module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

    wire [7:0] index;   // Intermediate wire to hold the index calculated from the selection vector
    wire  selected_bit; // Intermediate wire to hold the selected bit from the input vector

    // Calculate the index using the selection vector
    assign index = sel;

    // Calculate the selected bit from the input vector
    assign selected_bit = in[index];

    // Output the selected bit
    assign out = selected_bit;

endmodule
