module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Declare internal signals
    wire x;
    
    // Instantiate half adder module
    half_adder HA1 (a, b, sum, x);
    
    // Assign carry-out
    assign cout = x;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);

    // Logic for sum
    assign sum = a ^ b;
    
    // Logic for carry-out
    assign cout = a & b;

endmodule
