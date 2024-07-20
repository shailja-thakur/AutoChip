module top_module(
    input a, 
    input b,
    input c,
    output reg out
);

always @(a or b or c)
begin
    case({a,b})
        2'b00: out = 0;
        2'b01: out = 1;
        2'b10: out = 1;
        2'b11: out = 1;
    endcase
end

endmodule
