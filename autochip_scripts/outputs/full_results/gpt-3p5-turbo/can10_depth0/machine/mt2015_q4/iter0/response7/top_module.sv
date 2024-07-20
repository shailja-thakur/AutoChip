module top_module(
	input x,
	input y,
	output z);
    
    wire a;
    wire b;
    
    // First logic gate
    and u1(a, x, y);
    
    // Second logic gate
    xor u2(b, x, y);
    
    // Third logic gate
    or u3(z, a, b);
endmodule
