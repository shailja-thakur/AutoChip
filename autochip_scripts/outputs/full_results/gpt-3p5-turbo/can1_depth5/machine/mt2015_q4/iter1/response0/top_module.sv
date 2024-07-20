module top_module(
	input wire x,
	input wire y,
	output wire z);

    // Gate 1
    wire gate1_out;
    and and1(gate1_out, x, ~y);

    // Gate 2
    wire gate2_out;
    and and2(gate2_out, ~x, y);

    // Gate 3
    wire gate3_out;
    or or1(gate3_out, gate1_out, gate2_out);

    // Output assignment
    assign z = gate3_out;

endmodule
module and(
    input wire a,
    input wire b,
    output wire out
    );
    assign out = a & b;
endmodule
module or(
    input wire a,
    input wire b,
    output wire out
    );
    assign out = a | b;
endmodule
