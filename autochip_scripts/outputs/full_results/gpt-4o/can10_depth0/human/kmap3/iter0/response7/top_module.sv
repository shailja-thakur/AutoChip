module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000: out = 0; // 00 corresponds to 0 in the Karnaugh map
        4'b0001: out = 'bx; // 01 corresponds to don't care, but setting it to an arbitrary value
        4'b0010: out = 1; // 10 corresponds to 1 in the Karnaugh map
        4'b0011: out = 1; // 11 corresponds to 1 in the Karnaugh map

        4'b0100: out = 0; // 00 corresponds to 0 in the Karnaugh map
        4'b0101: out = 0; // 01 corresponds to 0 in the Karnaugh map
        4'b0110: out = 'bx; // 10 corresponds to don't care
        4'b0111: out = 'bx; // 11 corresponds to don't care

        4'b1000: out = 0; // 00 corresponds to 0 in the Karnaugh map
        4'b1001: out = 0; // 01 corresponds to 0 in the Karnaugh map
        4'b1010: out = 1; // 10 corresponds to 1 in the Karnaugh map
        4'b1011: out = 1; // 11 corresponds to 1 in the Karnaugh map

        4'b1100: out = 1; // 00 corresponds to 1 in the Karnaugh map
        4'b1101: out = 1; // 01 corresponds to 1 in the Karnaugh map
        4'b1110: out = 1; // 10 corresponds to 1 in the Karnaugh map
        4'b1111: out = 1; // 11 corresponds to 1 in the Karnaugh map
        
        default: out = 0; // Default output value
    endcase
end

endmodule
