module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    
    // Declare internal wires
    wire sum_internal, cout_internal;
    
    // Instantiate and connect the half adder module
    half_adder half_adder_inst (
        .a(a),
        .b(b),
        .sum(sum_internal),
        .cout(cout_internal)
    );
    
    // Output connections
    assign sum = sum_internal;
    assign cout = cout_internal;
    
endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);
    
    // Logic gates for sum and carry-out
    assign sum = a ^ b;
    assign cout = a & b;
    
endmodule
