module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg out_z;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or negedge areset) begin
	// Reset state on negative edge of areset input
	if (!areset)
		state <= A;
	else begin
		case(state)
			A: begin
				if (x)
					state <= B;
				else
					state <= A;
				out_z <= x;
			end
			B: begin
				if (x)
					state <= B;
				else
					state <= B;
				out_z <= ~x;
			end
		endcase
	end
end

assign z = out_z;

endmodule
