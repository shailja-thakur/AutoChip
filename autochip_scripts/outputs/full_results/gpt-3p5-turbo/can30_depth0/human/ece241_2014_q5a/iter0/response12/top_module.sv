module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [2:0] next_state;
reg [2:0] two_complement;

always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 3'b000;
	else
		state <= next_state;
end

always @(state, x) begin
	case (state)
		3'b000: begin // Start state
			if (x == 1'b0)
				next_state <= 3'b000;
			else
				next_state <= 3'b001;
		end
		3'b001: begin // Complementing state
			if (x == 1'b0)
				next_state <= 3'b010;
			else
				next_state <= 3'b001;
		end
		3'b010: begin // Twos complement state
			if (x == 1'b0)
				next_state <= 3'b010;
			else
				next_state <= 3'b011;
		end
		3'b011: begin // Completed state
			next_state <= 3'b011;
		end
	endcase
end

always @(posedge clk, posedge areset) begin
	if (areset)
		two_complement <= 3'b000;
	else if (state == 3'b000)
		two_complement <= 3'b000;
	else if (state == 3'b001)
		two_complement <= ~x;
	else if (state == 3'b010)
		two_complement <= two_complement + 1;
	end
end

assign z = two_complement;

endmodule
