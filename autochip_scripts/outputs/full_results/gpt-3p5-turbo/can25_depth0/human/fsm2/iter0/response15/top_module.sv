module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg out;
	reg [1:0] state;
	always @(posedge clk or posedge areset)
	begin
		if(areset)
			state <= 0;
		else if(state == 0)
		begin
			if(j == 1)
				state <= 1;
			else
				state <= 0;
		end
		else if(state == 1)
		begin
			if(k == 1)
				state <= 0;
			else
				state <= 1;
		end
	end

	always @(state)
	begin
		case(state)
			0: out <= 0;
			1: out <= 1;
		endcase
	end

endmodule
