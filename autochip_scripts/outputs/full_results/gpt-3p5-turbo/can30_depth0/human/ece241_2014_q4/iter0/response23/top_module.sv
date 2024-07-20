module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire q1, q2, q3;

assign z = ~(q1 ^ q2 ^ q3);

DFF dff1(clk, d1, q1);
DFF dff2(clk, d2, q2);
DFF dff3(clk, d3, q3);

xor x1(x, q1, d1);
and a1(x, ~q2, d2);
or o1(x, ~q3, d3);

endmodule
module DFF(
    input clk,
    input d,
    output reg q
);

always @(posedge clk)
begin
    q <= d;
end

endmodule
module xor(
    input a,
    input b,
    output reg c
);

always @(a, b)
begin
    c <= a ^ b;
end

endmodule
module and(
    input a,
    input b,
    output reg c
);

always @(a, b)
begin
    c <= a & b;
end

endmodule
module or(
    input a,
    input b,
    output reg c
);

always @(a, b)
begin
    c <= a | b;
end

endmodule
