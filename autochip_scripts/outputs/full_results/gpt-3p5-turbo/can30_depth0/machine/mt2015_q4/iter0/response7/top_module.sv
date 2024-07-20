module top_module(
	input x,
	input y,
	output z);

    wire a, b;

    assign a = x;
    assign b = y;

    and_gate and1(
        .a(a),
        .b(b),
        .out(w1)
    );

    and_gate and2(
        .a(b),
        .b(a),
        .out(w2)
    );

    and_gate and3(
        .a(w1),
        .b(w2),
        .out(z)
    );

endmodule
module and_gate(
    input a,
    input b,
    output out
);
    assign out = a & b;
endmodule
