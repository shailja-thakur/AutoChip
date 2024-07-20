module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		case (state)
			3'b000: begin
				if (w) begin
					state <= 3'b000;
				end else begin
					state <= 3'b001;
				end
			end
			3'b001: begin
				if (w) begin
					state <= 3'b010;
				end else begin
					state <= 3'b001;
				end
			end
			3'b010: begin
				if (w) begin
					state <= 3'b100;
				end else begin
					state <= 3'b011;
				end
			end
			3'b011: begin
				if (w) begin
					state <= 3'b010;
				end else begin
					state <= 3'b100;
				end
			end
			3'b100: begin
				if (w) begin
					state <= 3'b101;
				end else begin
					state <= 3'b100;
				end
			end
			3'b101: begin
				if (w) begin
					state <= 3'b101;
				end else begin
					state <= 3'b100;
				end
			end
		endcase
	end
end

always @(state) begin
	case (state)
		3'b000: z = 1'b0;
		3'b001: z = 1'b0;
		3'b010: z = 1'b0;
		3'b011: z = 1'b0;
		3'b100: z = 1'b0;
		3'b101: z = 1'b1;
	endcase
end

endmodule
