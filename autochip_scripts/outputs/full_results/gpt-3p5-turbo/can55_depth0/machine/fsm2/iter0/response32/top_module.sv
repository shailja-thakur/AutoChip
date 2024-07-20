module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	reg [1:0] state, next_state;
	
	always @(*) begin
		if (state == 2'b00) begin // State A
			if (j) begin
				next_state = 2'b01; // Next state B
			end else begin
				next_state = 2'b00; // Next state A
			end
		end else if (state == 2'b01) begin // State B
			if (k) begin
				next_state = 2'b00; // Next state A
			end else begin
				next_state = 2'b01; // Next state B
			end
		end
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset to state A
		end else begin
			state <= next_state; // Update state
		end
	end
	
	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output high if state is B, low otherwise

endmodule
