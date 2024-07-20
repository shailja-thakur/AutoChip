module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

// A priority encoder is a combinational circuit that, when given an input bit vector, outputs the position of the first 1 bit in the vector. 
// For example, a 8-bit priority encoder given the input 8'b10010000 would output 3'd4, because bit[4] is first bit that is high. 
// Build a 4-bit priority encoder. For this problem, if none of the input bits are high (i.e., input is zero), output zero. 
// Note that a 4-bit number has 16 possible combinations.

always @*
begin
    case(in)
        4'b0000: pos = 2'b00; // No bits are high, so output is zero
        4'b0001: pos = 2'b00; // Only bit[0] is high, so output is zero
        4'b0010: pos = 2'b01; // Only bit[1] is high, so output is 1
        4'b0011: pos = 2'b01; // Only bit[1] and bit[0] are high, so output is 1
        4'b0100: pos = 2'b10; // Only bit[2] is high, so output is 2
        4'b0101: pos = 2'b10; // Only bit[2] and bit[0] are high, so output is 2
        4'b0110: pos = 2'b10; // Only bit[2] and bit[1] are high, so output is 2
        4'b0111: pos = 2'b10; // Only bit[2], bit[1], and bit[0] are high, so output is 2
        4'b1000: pos = 2'b11; // Only bit[3] is high, so output is 3
        4'b1001: pos = 2'b11; // Only bit[3] and bit[0] are high, so output is 3
        4'b1010: pos = 2'b11; // Only bit[3] and bit[1] are high, so output is 3
        4'b1011: pos = 2'b11; // Only bit[3], bit[1], and bit[0] are high, so output is 3
        4'b1100: pos = 2'b11; // Only bit[3] and bit[2] are high, so output is 3
        4'b1101: pos = 2'b11; // Only bit[3], bit[2], and bit[0] are high, so output is 3
        4'b1110: pos = 2'b11; // Only bit[3], bit[2], and bit[1] are high, so output is 3
        4'b1111: pos = 2'b11; // All bits are high, so output is 3
    endcase
end

endmodule
