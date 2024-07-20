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

    // Internal wire to store the AND operation result
    wire p1_and_result, p2_and_result;

    // 4-input AND gates for p1 and p2
    and gate1(p1a, p1b, p1c, p1d, p1_and_result);
    and gate2(p2a, p2b, p2c, p2d, p2_and_result);

    // Inverter for p1y and p2y outputs
    not inv1(p1_and_result, p1y);
    not inv2(p2_and_result, p2y);

endmodule
module and(
    input a,
    input b,
    input c,
    input d,
    output y
);

    // Internal wires for the intermediate AND operations
    wire ab_and, cd_and;

    // AND gates for a & b, and c & d
    and ab_gate(a, b, ab_and);
    and cd_gate(c, d, cd_and);

    // Final AND gate for ab_and & cd_and
    and final_gate(ab_and, cd_and, y);

endmodule
module and(
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module not(
    input a,
    output y
);
    assign y = ~a;
endmodule
