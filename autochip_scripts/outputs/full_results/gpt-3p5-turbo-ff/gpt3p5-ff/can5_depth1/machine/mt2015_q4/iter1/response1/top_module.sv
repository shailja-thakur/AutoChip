module top_module(
    input x,
    input y,
    output z);

    // Define internal signals
    wire a1, a2, b1, b2;
    wire a3, b3;
    
    // Instantiate logic gates
    and_gate and1(a1, x, y);
    and_gate and2(a2, y, x);
    or_gate or1(a3, a1, b1);
    or_gate or2(b3, a2, b2);
    and_gate and3(z, a3, b3);

endmodule
module and_gate(
    output wire out,
    input wire a,
    input wire b);
    
    assign out = a & b;

endmodule
module or_gate(
    output wire out,
    input wire a,
    input wire b);
    
    assign out = a | b;

endmodule
