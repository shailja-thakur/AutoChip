module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    // Calculate the starting index of the 4-bit block
    integer idx;
    idx = sel * 4;
    // Select the 4-bit block from the input vector
    out = in[idx+:4];
end

endmodule
