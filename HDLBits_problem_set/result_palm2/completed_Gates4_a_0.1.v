module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    AND gate1 (
        input [3:0] a,
        input [3:0] b,
        output out
    );

    OR gate2 (
        input [3:0] a,
        input [3:0] b,
        output out
    );

    XOR gate3 (
        input [3:0] a,
        input [3:0] b,
        output out
    );

    assign out_and = gate1.out;
    assign out_or = gate2.out;
    assign out_xor = gate3.out;

endmodule