module top_module (
    input x3,
    input x2,
    input x1,
    output reg f
);

always @(x3 or x2 or x1)
begin
    f = (x3 & x2 & x1) | (x3 & ~x2 & x1) | (~x3 & x2 & ~x1) | (~x3 & x2 & x1);
end

endmodule
