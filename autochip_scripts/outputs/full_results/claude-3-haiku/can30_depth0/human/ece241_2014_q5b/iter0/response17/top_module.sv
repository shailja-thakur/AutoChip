module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

localparam STATE_A = 2'b01;
localparam STATE_B = 2'b10;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
	case (state)
		STATE_A: begin
			if (x == 1'b0) begin
				next_state = STATE_A;
			end else begin
				next_state = STATE_B;
			end
		end
		STATE_B: begin
			if (x == 1'b0) begin
				next_state = STATE_B;
			end else begin
				next_state = STATE_B;
			end
		end
		default: begin
			next_state = STATE_A;
		end
	endcase
end

// Output logic
always @(*) begin
	case (state)
		STATE_A: begin
			z = x;
		end
		STATE_B: begin
			z = ~x;
		end
		default: begin
			z = 1'b0;
		end
	endcase
end

// State register
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= STATE_A;
	end else begin
		state <= next_state;
	end
end

endmodule
