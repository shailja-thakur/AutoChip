module top_module(
	input x,
	input y,
	output z);

    wire a_in_first_gate;
    wire b_in_first_gate;
    wire a_in_second_gate;
    wire b_in_second_gate;
    wire a_in_third_gate;
    
    // First gate
    and_gate and_gate1 (.a(x), .b(y), .z(a_in_first_gate)); 
    
    // Second gate
    or_gate or_gate1 (.a(y), .b(x), .z(b_in_first_gate));

    // Third gate
    xor_gate xor_gate1 (.a(a_in_first_gate), .b(b_in_first_gate), .z(z));

endmodule
module and_gate(
    input a,
    input b,
    output z);
    assign z = a & b;
endmodule
module or_gate(
    input a,
    input b,
    output z);
    assign z = a | b;
endmodule
module xor_gate(
    input a,
    input b,
    output z);
    assign z = a ^ b;
endmodule
