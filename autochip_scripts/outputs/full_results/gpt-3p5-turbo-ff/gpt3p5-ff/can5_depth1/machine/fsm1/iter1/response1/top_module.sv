module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk or posedge areset) begin
		if(areset) begin
			state <= 2'b01;
		end else begin
			state <= next_state;
			if(state == 2'b00) begin
				if(in)
					next_state <= 2'b00;
				else
					next_state <= 2'b01;
			end else begin
				if(in)
					next_state <= 2'b01;
				else
					next_state <= 2'b00;
			end
		end
	end

	always @(posedge clk) begin
		if(areset)
			out <= 1'b1;
		else
			out <= (state == 2'b01) ? 1'b1 : 1'b0;
	end

endmodule
