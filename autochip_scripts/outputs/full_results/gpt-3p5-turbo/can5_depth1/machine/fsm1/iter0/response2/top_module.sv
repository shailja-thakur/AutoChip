module top_module (
	input clk,
	input in,
	input areset,
	output out
); 

reg [1:0] state;
wire next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b01; // Reset to state B
	end else begin
		state <= next_state; // Update state
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

always @* begin
	if (state == 2'b00 && in) begin // State A
		next_state = 2'b00; // Next state is A
	end else if (state == 2'b00 && !in) begin // State A
		next_state = 2'b01; // Next state is B
	end else if (state == 2'b01 && in) begin // State B
		next_state = 2'b01; // Next state is B
	end else if (state == 2'b01 && !in) begin // State B
		next_state = 2'b00; // Next state is A
	end
end

endmodule
