	parameter A=0, B=1, C=2, D=3;
    
    assign next_state[A] = (state[A] | state[C]) & ~in;
    assign next_state[B] = (state[A] | state[B] | state[D]) & in;
    assign next_state[C] = (state[B] | state[D]) & ~in;
    assign next_state[D] = state[C] & in;
    
	assign out = (state[D]);
	
endmodule
