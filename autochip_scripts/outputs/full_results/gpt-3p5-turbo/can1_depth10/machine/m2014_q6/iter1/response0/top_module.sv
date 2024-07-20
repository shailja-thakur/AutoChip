module top_module (
	input wire clk,
	input wire reset,
	input wire w,
	output wire z
);

	reg [2:0] state, next_state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			3'b000: begin // State A
				if (w) begin
					next_state = 3'b000; // State A
				end else begin
					next_state = 3'b001; // State B
				end
			end
			3'b001: begin // State B
				if (w) begin
					next_state = 3'b011; // State D
				end else begin
					next_state = 3'b010; // State C
				end
			end
			3'b010: begin // State C
				if (w) begin
					next_state = 3'b011; // State D
				end else begin
					next_state = 3'b100; // State E
				end
			end
			3'b011: begin // State D
				if (w) begin
					next_state = 3'b000; // State A
				end else begin
					next_state = 3'b101; // State F
				end
			end
			3'b100: begin // State E
				if (w) begin
					next_state = 3'b011; // State D
				end else begin
					next_state = 3'b100; // State E
				end
			end
			3'b101: begin // State F
				if (w) begin
					next_state = 3'b011; // State D
				end else begin
					next_state = 3'b010; // State C
				end
			end
			default: begin
				next_state = 3'b000; // State A
			end
		endcase
	end

	assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
