module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    wire s1, c1, c2;
    
    // First stage (half adder)
    xor_gate xor1 (.a(a), .b(b), .out(s1));
    and_gate and1 (.a(a), .b(b), .out(c1));
    
    // Second stage (full adder)
    xor_gate xor2 (.a(s1), .b(cin), .out(sum));
    and_gate and2 (.a(s1), .b(cin), .out(c2));
    or_gate or1 (.a(c1), .b(c2), .out(cout));
    
endmodule
