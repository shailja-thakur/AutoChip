module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;

// State enumeration
parameter A = 2'b00;
parameter B = 2'b01;

// State transition logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Next state and output logic
always @(*) begin
	case (state)
		A: begin
			if (x) begin
				next_state = B;
				z = 1'b1;
			end else begin
				next_state = A;
				z = 1'b0;
			end
		end
		B: begin
			if (x) begin
				next_state = B;
				z = 1'b0;
			end else begin
				next_state = B;
				z = 1'b1;
			end
		end
		default: begin
			next_state = A;
			z = 1'b0;
		end
	endcase
end

endmodule
