module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter IDLE = 3'b000;
parameter CONVERSION = 3'b001;
parameter RESET = 3'b010;
parameter FINISH = 3'b011;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= RESET;
		z <= 0;
	end
	else begin
		state <= next_state;
		case (state)
			IDLE: begin
				if (x != 1'b0)
					next_state <= CONVERSION;
				else
					next_state <= IDLE;
			end
			CONVERSION: begin
				if (x != 1'b0)
					next_state <= CONVERSION;
				else
					next_state <= FINISH;
			end
			RESET: begin
				next_state <= IDLE;
			end
			FINISH: begin
				next_state <= RESET;
			end
			default: begin
				next_state <= IDLE;
			end
		endcase
	end
end

always @(posedge clk or posedge areset) begin
	if (areset)
		z <= 0;
	else begin
		case (state)
			IDLE: begin
				z <= 0;
			end
			CONVERSION: begin
				z <= ~x + 1'b1;
			end
			default: begin
				z <= 0;
			end
		endcase
	end
end

endmodule
