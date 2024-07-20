module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    // Wire to store selected bit
    wire selected_bit;
  
    // Assigns selected bit from input vector based on selection vector
    assign selected_bit = in[sel];
  
    // Output is the selected bit
    assign out = selected_bit;

endmodule
