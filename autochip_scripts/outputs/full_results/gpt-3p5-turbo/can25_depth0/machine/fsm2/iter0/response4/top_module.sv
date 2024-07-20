module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] current_state, next_state;

// Combinational always block to determine the next state
always @(*) begin
	if (current_state == 2'b00) begin
		if (j) begin
			next_state = 2'b01;
		end else begin
			next_state = 2'b00;
		end
	end else if (current_state == 2'b01) begin
		if (k) begin
			next_state = 2'b00;
		end else begin
			next_state = 2'b01;
		end
	end
end

// Clocked always block to update the state of the FSM
always @(posedge clk or posedge areset) begin
	if (areset) begin
		current_state <= 2'b00;
	end else begin
		current_state <= next_state;
	end
end

// Assign out port based on current state
assign out = (current_state == 2'b01) ? 1'b1 : 1'b0;

endmodule
