module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire x;
wire y;

xor(x, a, b);
xor(y, c, d);
xor(q, x, y);

endmodule
