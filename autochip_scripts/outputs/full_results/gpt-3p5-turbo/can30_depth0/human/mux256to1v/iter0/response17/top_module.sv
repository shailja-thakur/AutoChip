module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [7:0] index;
assign index = sel * 4; // Calculate the starting index based on sel

assign out = in[index +: 4]; // Extract 4 bits starting from the calculated index
endmodule
