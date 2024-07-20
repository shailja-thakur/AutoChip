module top_module(
    input x,
    input y,
    output z);

    // Intermediate signals
    wire out1, out2;

    // First and second gates use x and y in reversed positions
    and_gate gate1 ( 
        .a(x), 
        .b(y), 
        .out(out1)
    );

    or_gate gate2 (
        .a(y), 
        .b(x), 
        .out(out2)
    );

    // Third gate combines outputs of first two gates
    xor_gate gate3 (
        .a(out1), 
        .b(out2), 
        .out(z)
    );

endmodule
module and_gate(
    input a,
    input b,
    output out);

    assign out = a & b;

endmodule
module or_gate(
    input a,
    input b,
    output out);

    assign out = a | b;
    
endmodule
module xor_gate(
    input a,
    input b,
    output out);

    assign out = a ^ b;

endmodule
