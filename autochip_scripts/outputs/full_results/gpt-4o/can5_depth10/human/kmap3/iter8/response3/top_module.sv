module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        // ab cd values from the Karnaugh map
        4'b0001, 4'b0010, 4'b0011,  // d000x is don't care
        4'b1001, // abcd=10 00
        4'b1010, 4'b1011, // abcd=10 01,10,11
        4'b1100, 4'b1101, 4'b1110, 4'b1111: out = 1'b1; // abcd=11 xx and dcd=10 11
        4'b0000, 4'b0100,  // abcd=00 00,01
        4'b0101, 4'b0110, 4'b0111,  // abcd=01 xx
        4'b1000, 4'b1100,  // abcd=0x 11  x=0 don't care
         out = 1'b0;
        default: out = 1'b0; // Default to 0 for safety
    endcase
end

endmodule
