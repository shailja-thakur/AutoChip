module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

    and_gate and1 (
        .inp1(p1a), 
        .inp2(p1b), 
        .inp3(p1c), 
        .inp4(p1d),
        .out(p1y)
    );

    and_gate and2 (
        .inp1(p2a), 
        .inp2(p2b), 
        .inp3(p2c), 
        .inp4(p2d),
        .out(p2y)
    );

endmodule
module and_gate(
    input inp1,
    input inp2,
    input inp3,
    input inp4,
    output out
);
    wire w1;
    wire w2;

    assign w1 = inp1 & inp2;
    assign w2 = inp3 & inp4;

    assign out = ~(w1 & w2);

endmodule
