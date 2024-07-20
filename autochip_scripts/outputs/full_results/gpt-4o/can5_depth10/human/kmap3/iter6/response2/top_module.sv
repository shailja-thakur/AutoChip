module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        // cd = 00
        4'b0001, 4'b0010, 4'b0011: out = 1'b1; // ab -> 01, 10, 11
        4'b0000: out = 1'b0; // ab -> 00

        // cd = 01
        4'b0100, 4'b0101: out = 1'b0; // ab -> 00, 01
        // For cd = 01 and ab -> 10, 11 it's don't-care; choose 1'b0 for simplicity
        4'b0110, 4'b0111: out = 1'b0;

        // cd = 10
        4'b1001, 4'b1010, 4'b1011: out = 1'b1; // ab -> 01, 10, 11
        4'b1000: out = 1'b0; // ab -> 00

        // cd = 11
        4'b1101, 4'b1110, 4'b1111: out = 1'b1; // ab -> 01, 10, 11
        4'b1100: out = 1'b0; // ab -> 00

        default: out = 1'b0; // Default to 0 for safety
    endcase
end

endmodule
