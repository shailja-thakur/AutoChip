module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
reg z_next;
wire z;

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
			z_next = x;
		end
		B: begin
			if (x) begin
				next_state = B;
			end else begin
				next_state = B;
			end
			z_next = ~x;
		end
	endcase
end

assign z = z_next;

endmodule
