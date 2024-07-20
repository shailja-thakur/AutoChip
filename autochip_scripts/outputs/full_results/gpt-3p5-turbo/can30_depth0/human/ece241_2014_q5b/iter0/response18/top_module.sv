module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
reg temp_z;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

always @(state, x) begin
	case (state)
		A: begin
			if (x)
				next_state = B;
			else
				next_state = A;
			temp_z = x;
		end
		B: begin
			if (x)
				next_state = B;
			else
				next_state = B;
			temp_z = ~x;
		end
	endcase
end

assign z = temp_z;

endmodule
