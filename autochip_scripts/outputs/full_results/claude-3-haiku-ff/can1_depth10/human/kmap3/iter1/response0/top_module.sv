module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({a, b})
        2'b00: out = c;
        2'b01, 2'b11: out = 1;
        2'b10: out = d;
    endcase
end

endmodule
