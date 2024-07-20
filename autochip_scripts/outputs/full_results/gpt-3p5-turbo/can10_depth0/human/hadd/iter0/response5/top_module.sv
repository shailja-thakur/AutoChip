module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Define internal signals
    wire s;
    wire c;

    // Instantiate the half adder module
    half_adder ha1 (
        .a(a),
        .b(b),
        .sum(s),
        .carry(c)
    );

    // Assign the internal signals to the outputs
    assign sum = s;
    assign cout = c;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output carry
);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule
