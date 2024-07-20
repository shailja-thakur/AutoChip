module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

always @(state or x) begin
	case (state)
		A: begin
			if (x)
				next_state <= B;
			else
				next_state <= A;
		end
		B: begin
			if (x)
				next_state <= B;
			else
				next_state <= B;
		end
	endcase
end

assign z = (state == B) ? 1'b0 : 1'b1;

endmodule
