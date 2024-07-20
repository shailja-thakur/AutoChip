module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    
    // Declare internal wire for sum and carry-out
    wire sum_wire, carry_out_wire;
    
    // Instantiate half adder module
    half_adder HA(.a(a), .b(b), .sum(sum_wire), .carry_out(carry_out_wire));
    
    // Assign sum and carry-out outputs
    assign sum = sum_wire;
    assign cout = carry_out_wire;
    
endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output carry_out
);
    assign sum = a ^ b;       // XOR gate for sum
    assign carry_out = a & b; // AND gate for carry-out
endmodule
