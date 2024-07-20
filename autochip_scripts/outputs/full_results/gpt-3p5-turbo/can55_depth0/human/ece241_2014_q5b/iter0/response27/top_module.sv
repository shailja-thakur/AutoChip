module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
localparam A = 2'b00;
localparam B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
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

assign z = (state == B);

endmodule
