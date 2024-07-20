module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State declaration
	reg [2:0] state;

	// State transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case(state)
				3'b000: begin // State A
					if (w) begin
						state <= 3'b000;
					end else begin
						state <= 3'b001;
					end
				end

				3'b001: begin // State B
					if (w) begin
						state <= 3'b100;
					end else begin
						state <= 3'b001;
					end
				end

				3'b010: begin // State C
					if (w) begin
						state <= 3'b010;
					end else begin
						state <= 3'b011;
					end
				end

				3'b011: begin // State D
					if (w) begin
						state <= 3'b100;
					end else begin
						state <= 3'b001;
					end
				end

				3'b100: begin // State E
					if (w) begin
						state <= 3'b100;
					end else begin
						state <= 3'b011;
					end
				end

				3'b101: begin // State F
					if (w) begin
						state <= 3'b010;
					end else begin
						state <= 3'b011;
					end
				end
			endcase
		end
	end

	// Outputs
	assign z = (state == 3'b000) ? 1'b0 : 1'b1;

endmodule
