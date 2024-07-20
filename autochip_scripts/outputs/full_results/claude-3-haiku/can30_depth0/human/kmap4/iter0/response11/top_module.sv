module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({a, b})
        2'b00: out = c ^ d;
        2'b01: out = ~(c ^ d);
        2'b11: out = c ^ d;
        2'b10: out = ~(c ^ d);
    endcase
end

endmodule
