module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		z <= 0;
	end else begin
		case (state)
			3'b000: begin // State A
				if (w == 1'b0) begin
					state <= 3'b000;
					z <= 0;
				end else begin
					state <= 3'b001;
					z <= 0;
				end
			end
			3'b001: begin // State B
				if (w == 1'b0) begin
					state <= 3'b010;
					z <= 0;
				end else begin
					state <= 3'b010;
					z <= 0;
				end
			end
			3'b010: begin // State C
				if (w == 1'b0) begin
					state <= 3'b010;
					z <= 0;
				end else begin
					state <= 3'b100;
					z <= 0;
				end
			end
			3'b011: begin // State D
				if (w == 1'b0) begin
					state <= 3'b000;
					z <= 0;
				end else begin
					state <= 3'b011;
					z <= 0;
				end
			end
			3'b100: begin // State E
				if (w == 1'b0) begin
					state <= 3'b011;
					z <= 0;
				end else begin
					state <= 3'b100;
					z <= 1;
				end
			end
			3'b101: begin // State F
				if (w == 1'b0) begin
					state <= 3'b011;
					z <= 0;
				end else begin
					state <= 3'b101;
					z <= 1;
				end
			end
			default: begin // Default state
				state <= 3'b000;
				z <= 0;
			end
		endcase
	end
end

endmodule
