module top_module(
    input x,
    input y,
    output z);

    wire a;
    wire b;
    wire c;

    and gate1(a, x, y);
    not gate2(b, a);
    xor gate3(c, x, y);
    and gate4(z, b, c);
    
endmodule
