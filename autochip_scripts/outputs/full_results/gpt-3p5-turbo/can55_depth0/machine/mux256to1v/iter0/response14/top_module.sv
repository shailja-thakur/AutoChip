module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [3:0] index; // Variable to save the starting index of the 4-bit block
    wire [1023:0] selected_block; // Wire to store the selected 4-bit block from the input vector

    always @* begin
        index = sel * 4; // Calculate the starting index of the 4-bit block
        selected_block = in[index +: 4]; // Extract the 4-bit block from the input vector
    end

    assign out = selected_block; // Assign the selected block to the output vector

endmodule
