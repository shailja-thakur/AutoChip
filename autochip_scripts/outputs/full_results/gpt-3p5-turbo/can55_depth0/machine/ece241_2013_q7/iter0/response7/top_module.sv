module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

	always @(posedge clk) // triggered on rising edge of clk
	begin
		if(j & ~Q) // AND operation between j and ~Q
			Q <= j; // set Q to j
		else if(~k & Q) // OR operation between ~k and Q
			Q <= 0; // reset Q to 0
		else if(j & k) // toggle case, both j and k are high
			Q <= ~Q; // toggle Q
	end
endmodule
