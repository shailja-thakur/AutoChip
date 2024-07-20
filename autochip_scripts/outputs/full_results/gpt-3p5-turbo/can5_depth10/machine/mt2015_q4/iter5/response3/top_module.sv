module top_module(
    input x,
    input y,
    output reg z
);

    wire a;
    wire b;

    and gate1(a, x, y);
    or gate2(b, y, x);
    or gate3(z, a, b);

    always @(x or y) begin
        gate1 = x & y;
        gate2 = y | x;
        gate3 = a | b;
    end

endmodule
