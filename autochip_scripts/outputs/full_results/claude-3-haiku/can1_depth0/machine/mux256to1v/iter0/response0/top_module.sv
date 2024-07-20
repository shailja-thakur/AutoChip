module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    // Calculate the starting index of the 4-bit block based on the selection vector (sel)
    integer start_index = sel * 4;
    
    // Extract the 4-bit block from the input vector (in) and assign it to the output vector (out)
    out = in[start_index +: 4];
end

endmodule
