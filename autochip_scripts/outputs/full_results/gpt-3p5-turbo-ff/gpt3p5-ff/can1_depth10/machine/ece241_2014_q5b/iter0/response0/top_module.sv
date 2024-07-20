module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state;
wire posedge_x;
assign posedge_x = x & ~x;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		case(state)
			A: begin
				if (posedge_x)
					state <= B;
				else
					state <= A;
			end
			B: begin
				state <= B;
			end
		endcase
	end
end

assign z = (state == A && x) || (state == B && ~x);

endmodule
