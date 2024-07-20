module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// state declaration
	reg state;
	
	// output assignment
	assign out = (state == 1'b0) ? 1'b1 : 1'b0;
	
	// state machine logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 1'b0;
		end else begin
			if (state == 1'b0) begin
				if (in) begin
					state <= 1'b0;
				end else begin
					state <= 1'b1;
				end
			end else begin
				if (in) begin
					state <= 1'b1;
				end else begin
					state <= 1'b0;
				end
			end
		end
	end
endmodule
