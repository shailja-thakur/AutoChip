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

    wire p1_input;
    wire p2_input;

    and gate_p1(p1a, p1b, p1c, p1d, p1_input);
    and gate_p2(p2a, p2b, p2c, p2d, p2_input);

    not invert_p1(p1_input, p1y);
    not invert_p2(p2_input, p2y);

    // AND gate implementation
    module and (
        input a, 
        input b, 
        input c, 
        input d, 
        output out
    );
        wire temp1;
        wire temp2;

        and2(temp1, a, b);
        and2(temp2, c, d);
        and2(out, temp1, temp2);
    endmodule
module and2 (
        input a,
        input b,
        output out
    );
        assign out = a & b;
    endmodule
module not (
        input in,
        output out
    );
        assign out = ~in;
    endmodule
