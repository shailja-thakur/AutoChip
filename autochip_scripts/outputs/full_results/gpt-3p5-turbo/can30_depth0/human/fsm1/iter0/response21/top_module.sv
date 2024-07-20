module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] current_state, next_state;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset)
		current_state <= B;
	else
		current_state <= next_state;
end

always @* begin
	case (current_state)
		B: begin
			if (in) next_state = B;
			else next_state = A;
		end
		A: begin
			if (in) next_state = A;
			else next_state = B;
		end
	endcase
end

assign out = (current_state == A) ? 1'b1 : 1'b0;

endmodule
