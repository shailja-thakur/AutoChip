module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Declare internal wires
    wire sum_wire;
    wire cout_wire;
    
    // Instantiate half adder module
    half_adder ha1 (
        .a(a),
        .b(b),
        .sum(sum_wire),
        .cout(cout_wire)
    );
  
    assign sum = sum_wire;
    assign cout = cout_wire;
  
endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);
  
    // Declare internal wires
    wire x;
  
    // Assign sum and cout
    assign sum = a ^ b;
    assign cout = a & b;
  
endmodule
