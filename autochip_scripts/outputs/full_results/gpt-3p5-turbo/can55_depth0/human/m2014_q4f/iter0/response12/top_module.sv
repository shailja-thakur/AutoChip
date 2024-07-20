module top_module (
    input in1,
    input in2,
    output logic out
);
    // Declare internal wire
    wire in2_inverted;

    // Invert input in2 using a NOT gate
    not_gate not1 (
        .in(in2),
        .out(in2_inverted)
    );

    // Perform logical AND between in1 and inverted in2
    and_gate and1 (
        .in1(in1),
        .in2(in2_inverted),
        .out(out)
    );

    // NOT gate sub-module
    module not_gate (
        input in,
        output out
    );
        assign out = ~in;
    endmodule
module and_gate (
        input in1,
        input in2,
        output out
    );
        assign out = in1 & in2;
    endmodule
