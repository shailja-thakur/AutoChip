module top_module(
    input x,
    input y,
    output z);

    wire first_gate_output;
    wire second_gate_output;

    and first_gate(first_gate_output, x, y);
    or second_gate(second_gate_output, y, x);
    xor third_gate(z, first_gate_output, second_gate_output);

endmodule
