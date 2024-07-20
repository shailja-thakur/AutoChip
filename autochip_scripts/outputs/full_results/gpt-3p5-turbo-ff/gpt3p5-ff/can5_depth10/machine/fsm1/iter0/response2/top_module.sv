module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	reg [1:0] state;
	initial
		state = 0;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b01;
		else begin
			case(state)
				2'b00: begin
					if (in)
						state <= 2'b00;
					else
						state <= 2'b01;
				end
				2'b01: begin
					if (in)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
			endcase
		end
	end
	
	always @(state) begin
		if (state == 2'b01)
			out <= 1'b1;
		else
			out <= 1'b0;
	end
endmodule
