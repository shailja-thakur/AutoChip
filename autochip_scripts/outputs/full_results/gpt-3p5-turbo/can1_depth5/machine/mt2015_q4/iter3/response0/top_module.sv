module top_module(
    input wire x,
    input wire y,
    output wire z);

    // Gate 1
    wire gate1_out;
    and gate1 (
        .a(x),
        .b(~y),
        .out(gate1_out)
    );

    // Gate 2
    wire gate2_out;
    and gate2 (
        .a(~x),
        .b(y),
        .out(gate2_out)
    );

    // Gate 3
    wire gate3_out;
    or gate3 (
        .a(gate1_out),
        .b(gate2_out),
        .out(gate3_out)
    );

    // Output assignment
    assign z = gate3_out;

endmodule
module and (
    input wire a,
    input wire b,
    output wire out
    );
    assign out = a & b;
endmodule
module or (
    input wire a,
    input wire b,
    output wire out
    );
    assign out = a | b;
endmodule
