module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    // Declare internal signals
    wire s, c;

    // Instantiate the half adder module
    half_adder ha(
        .a(a),
        .b(b),
        .sum(s),
        .carry(c)
    );

    // Assign the outputs of the half adder module to the module outputs
    assign sum = s;
    assign cout = c;
    
    // Define the half adder module
    module half_adder(
        input a,
        input b,
        output sum,
        output carry
    );
        assign sum = a ^ b;
        assign carry = a & b;
    endmodule
