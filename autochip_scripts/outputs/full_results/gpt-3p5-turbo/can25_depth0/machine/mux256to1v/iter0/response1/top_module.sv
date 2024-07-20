module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    
    reg [3:0] start_index;  // Registers to hold the starting index
    wire [1023:0] selected_block;  // Wire to hold the selected 4-bit block
    
    always @* begin
        start_index = sel << 2;  // Calculate the starting index
        selected_block = in[start_index +: 4];  // Extract the 4-bit block from the input vector
    end
    
    assign out = selected_block;  // Assign the selected block to the output
    
endmodule
