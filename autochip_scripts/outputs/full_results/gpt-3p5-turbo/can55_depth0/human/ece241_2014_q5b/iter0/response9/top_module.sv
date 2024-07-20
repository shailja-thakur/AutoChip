module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
reg out_z;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
		out_z <= 1'b0;
	end else begin
		state <= next_state;
		out_z <= (state == B) ? 1'b1 : 1'b0;
	end
end

always @(state or x) begin
	case (state)
		A: begin
			if (x) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		B: begin
			if (x) begin
				next_state = B;
			end else begin
				next_state = B;
			end
		end
		default: next_state = A;
	endcase
end

assign z = out_z;

endmodule
