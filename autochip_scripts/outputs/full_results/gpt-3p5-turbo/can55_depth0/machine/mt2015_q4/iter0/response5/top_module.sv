module top_module(
    input x,
    input y,
    output z);

    wire a, b;
    wire first_gate_output, second_gate_output;
    
    and gate_1(a, x, y);
    and gate_2(b, y, x);
    and gate_3(z, first_gate_output, second_gate_output);
    
endmodule
