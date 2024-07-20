module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

// combinational logic to determine next state
always @(*) begin
	if (state == 2'b00) begin
		if (j) begin
			next_state = 2'b01;
		end else begin
			next_state = 2'b00;
		end
	end else begin
		if (k) begin
			next_state = 2'b00;
		end else begin
			next_state = 2'b01;
		end
	end
end

// clocked logic to update state
always @(posedge clk) begin
	if (areset) begin
		state <= 2'b00;
	else
		state <= next_state;
	end
end

// output logic
assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
