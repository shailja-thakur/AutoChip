module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    wire [9:0] start_index; // 10-bit wide to cover the range 0 to 1023
    assign start_index = sel * 4;
    assign out = in[start_index +: 4]; // Concatenation to create a 4-bit slice
endmodule
