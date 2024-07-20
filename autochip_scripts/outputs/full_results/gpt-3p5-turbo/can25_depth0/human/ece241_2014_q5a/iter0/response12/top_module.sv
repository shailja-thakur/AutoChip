module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [3:0] state;
reg [3:0] next_state;
reg z;

parameter IDLE = 0;
parameter ADD_ONE = 1;
parameter NEGATE = 2;
parameter SUB_ONE = 3;

always @(posedge clk or negedge areset) begin
	if (areset) begin
		state <= IDLE;
	else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
	IDLE: begin
		if (x == 1'b1) begin
			next_state = NEGATE;
		end else begin
			next_state = ADD_ONE;
		end
	end

	ADD_ONE: begin
		if (x == 1'b1) begin
			next_state = ADD_ONE;
		end else begin
			next_state = NEGATE;
		end
	end

	NEGATE: begin
		next_state = SUB_ONE;
	end

	SUB_ONE: begin
		if (x == 1'b1) begin
			next_state = NEGATE;
		end else begin
			next_state = ADD_ONE;
		end
	end

	default: next_state = IDLE;
	endcase
end

always @(posedge clk or negedge areset) begin
	if (areset) begin
		z <= 1'b0;
	end else begin
		case (state)
		IDLE: begin
			z <= 1'b0;
		end

		ADD_ONE: begin
			z <= z + 1'b1;
		end

		NEGATE: begin
			z <= ~z;
		end

		SUB_ONE: begin
			z <= z - 1'b1;
		end
		endcase
	end
end

endmodule
