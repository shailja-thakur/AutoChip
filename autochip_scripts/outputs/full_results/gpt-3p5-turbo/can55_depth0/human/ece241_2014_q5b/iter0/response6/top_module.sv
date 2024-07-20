module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
wire next_z;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
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
	endcase
end

assign z = next_z;

always @(state) begin
	case (state)
		A: begin
			next_z = 1'b0;
		end

		B: begin
			next_z = 1'b1;
		end
	endcase
end

endmodule
