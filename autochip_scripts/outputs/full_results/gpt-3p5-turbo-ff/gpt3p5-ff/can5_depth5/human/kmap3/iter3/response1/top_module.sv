module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case({c, a, b})
        3'b000: out = d;
        3'b001: out = 0;
        3'b010: out = d;
        3'b011: out = d;
        3'b100: out = 1;
        3'b101: out = 1;
        3'b110: out = 1;
        3'b111: out = 1;
        default: out = 0; // Output don't-care value when inputs are invalid
    endcase
end

endmodule
