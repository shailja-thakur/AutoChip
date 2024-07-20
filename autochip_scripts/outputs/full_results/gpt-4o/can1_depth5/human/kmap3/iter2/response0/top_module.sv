module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c,d,a,b})
        4'b0010, 4'b0011, // When cd is 00 and ab is 10 or 11
        4'b0110, 4'b0111, // When cd is 01 and ab is 10 or 11
		4'b1110, 4'b1111, // When cd is 11 and ab is 10 or 11
        4'b1010, 4'b1011, // When cd is 10 and ab is 10 or 11
        4'b1100, 4'b1101: // When cd is 11 and ab is 00 or 01
        out = 1;
        default: out = 0;
    endcase
end

endmodule
