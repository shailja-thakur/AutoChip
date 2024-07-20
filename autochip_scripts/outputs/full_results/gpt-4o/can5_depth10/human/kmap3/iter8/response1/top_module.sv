module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0001: out = 1; // ab=01, cd=00
        4'b0010: out = 1; // ab=10, cd=00
        4'b0011: out = 1; // ab=11, cd=00
        4'b0110: out = 0; // ab=10, cd=01
        4'b0111: out = 0; // ab=11, cd=01    
        4'b1101, 4'b1110, 4'b1111, // ab=10 or 11, cd=11, 10
        4'b1010, 4'b1011,        // ab=01 or 01, cd=11,10
        4'b1000, 4'b1001: out =1 ;  //catch-all group out is 1 except specific cases
        default: out = 0; // General remaining case(default safer as low).
    endcase
end

endmodule
