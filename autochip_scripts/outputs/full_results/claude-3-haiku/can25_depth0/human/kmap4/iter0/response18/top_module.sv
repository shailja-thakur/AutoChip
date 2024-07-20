module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({a, b})
        2'b00, 2'b11: // ab = 00 or 11
            out = ~c & d | c & ~d;
        2'b01, 2'b10: // ab = 01 or 10
            out = ~c & ~d | c & d;
        default:
            out = 1'bx; // Unreachable case
    endcase
end

endmodule
