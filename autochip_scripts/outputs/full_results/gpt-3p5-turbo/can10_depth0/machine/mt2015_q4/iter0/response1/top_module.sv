module top_module(
	input wire x,
	input wire y,
	output wire z);

    wire a, b;
    
    // First gate
    and_gate u1(.a(x), .b(y), .z(a));
    
    // Second gate
    and_gate u2(.a(y), .b(x), .z(b));
    
    // Third gate
    and_gate u3(.a(a), .b(b), .z(z));

endmodule
