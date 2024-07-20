module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state;
reg z;

always @(posedge clk or negedge areset) begin
	if (~areset) begin
		state <= A;
	end else begin
		case (state)
			A: begin
				if (x) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			B: begin
				state <= B;
			end
		endcase
	end
end

always @(state or x) begin
	if ((state == A && x) || (state == B && ~x)) begin
		z <= 1;
	end else begin
		z <= 0;
	end
end

endmodule
