module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00;
	end else begin
		state <= next_state;
	end
end

always @(state, x) begin
	case (state)
		2'b00: begin
			if (x == 1'b0) begin
				next_state = 2'b00;
				z = 1'b0;
			end else begin
				next_state = 2'b01;
				z = 1'b1;
			end
		end
		2'b01: begin
			if (x == 1'b0) begin
				next_state = 2'b01;
				z = 1'b1;
			end else begin
				next_state = 2'b01;
				z = 1'b0;
			end
		end
		default: begin
			next_state = 2'b00;
			z = 1'b0;
		end
	endcase
end

endmodule
