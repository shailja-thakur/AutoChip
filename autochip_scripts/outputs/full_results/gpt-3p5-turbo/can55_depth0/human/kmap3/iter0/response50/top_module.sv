module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(a or b or c or d)
case({c, b, a})
    3'b000 : out = 1;
    3'b001 : out = d;
    3'b011 : out = 1;
    3'b010 : out = 1;
    3'b110 : out = 1;
    default : out = 1;
endcase

endmodule
