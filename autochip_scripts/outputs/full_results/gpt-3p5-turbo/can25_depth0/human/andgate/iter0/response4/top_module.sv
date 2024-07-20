module top_module(
    input a,
    input b,
    output out
);
    
    // Declare internal wire
    wire and_output;
    
    // Instantiate the AND gate
    and_gate and1(.a(a), .b(b), .out(and_output));
    
    // Assign the output of the AND gate to the module's output
    assign out = and_output;
    
endmodule
module and_gate(
    input a,
    input b,
    output out
);
    
    // Implement the AND gate using logical AND operator
    assign out = a & b;
    
endmodule
