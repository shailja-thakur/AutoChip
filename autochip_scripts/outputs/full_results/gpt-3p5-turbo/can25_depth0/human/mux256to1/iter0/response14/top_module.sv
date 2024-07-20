module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    // Create a wire to store the selected input
    wire [7:0] selected_input;
    
    // Create a wire to store each bit of the selected input
    wire [0:255] selected_bit;
    
    // Select the corresponding bits from the input based on the sel value
    assign selected_input = in[sel];
    
    // Split the selected input into individual bits
    assign selected_bit = selected_input;
    
    // Perform bitwise AND operation on each bit and assign the result to the output
    assign out = &selected_bit;

endmodule
