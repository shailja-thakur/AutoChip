module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    // Calculate the starting index based on the selection vector.
    // sel is an 8-bit value, each block is 4 bits, so sel index needs to multiply by 4
    integer start_index;
    start_index = sel * 4;

    // Extract the 4-bit block from the input vector based on the calculated starting index
    out = in[start_index +: 4];
end

endmodule
