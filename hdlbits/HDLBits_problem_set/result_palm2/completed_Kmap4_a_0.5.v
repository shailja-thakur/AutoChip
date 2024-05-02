module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out  ); 

    AND gate1 (
        output wire g1,
        input wire a,
        input wire b
    );

    AND gate2 (
        output wire g2,
        input wire a,
        input wire c
    );

    AND gate3 (
        output wire g3,
        input wire b,
        input wire c
    );

    AND gate4 (
        output wire g4,
        input wire a,
        input wire d
    );

    AND gate5 (
        output wire g5,
        input wire b,
        input wire d
    );

    OR gate1 (
        output wire o1,
        input wire g1,
        input wire g2
    );

    OR gate2 (
        output wire o2,
        input wire g3,
        input wire g4
    );

    OR gate3 (
        output wire o3,
        input wire g5,
        input wire g2
    );

    NOT gate1 (
        output wire n1,
        input wire o3
    );

    assign out = n1;

endmodule