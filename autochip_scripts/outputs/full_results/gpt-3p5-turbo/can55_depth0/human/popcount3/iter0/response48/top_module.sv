module top_module (
    input [2:0] in,
    output reg [1:0] out
);

always @(*) begin
    out[0] = in[0] + in[1] + in[2];  // Add up all the bits in the input vector
    out[1] = (in[0] & in[1]) | (in[1] & in[2]) | (in[0] & in[2]);  // Perform bitwise AND and OR operations to count the number of '1's
end

endmodule
