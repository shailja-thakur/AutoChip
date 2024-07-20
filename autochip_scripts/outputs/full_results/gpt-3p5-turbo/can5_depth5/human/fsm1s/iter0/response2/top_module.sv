module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= 2'b10; // reset state B
		else if (state == 2'b10) // B
		begin
			if (in)
				state <= 2'b10;
			else
				state <= 2'b01; // transition to A
		end
		else if (state == 2'b01) // A
		begin
			if (in)
				state <= 2'b01;
			else
				state <= 2'b10; // transition to B
		end
	end
	
	always @(state)
	begin
		case (state)
			2'b10: out = 1; // B
			2'b01: out = 0; // A
		endcase
	end
	
endmodule
