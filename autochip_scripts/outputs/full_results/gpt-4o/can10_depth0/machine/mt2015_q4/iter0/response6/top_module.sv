module top_module(
	input x,
	input y,
	output z);

    wire first_gate_out;
    wire second_gate_out;

    // First gate (AND gate in this example)
    assign first_gate_out = x & y;

    // Second gate (OR gate in this example)
    assign second_gate_out = x | y;

    // Third gate (XOR gate in this example)
    assign z = first_gate_out ^ second_gate_out;

endmodule
