module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	// Internal signals
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // initialize state to A
		else begin
			if (state == 2'b00) begin // state A
				if (j)
					state <= 2'b01; // next state is B
				else
					state <= 2'b00; // next state remains A
			end else begin // state B
				if (k)
					state <= 2'b00; // next state is A
				else
					state <= 2'b01; // next state remains B
			end
		end
	end
	
	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // output is high when state is B, low when state is A
	
endmodule
