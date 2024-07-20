module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);
	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001; // initializes state to A
		end else begin
			case (state)
				3'b000: begin // A
					if (x) begin
						state <= 3'b100; // B
					end else begin
						state <= 3'b000; // A
					end
				end
				3'b001: begin // B
					if (x) begin
						state <= 3'b101; // E
					end else begin
						state <= 3'b001; // B
					end
				end
				3'b010: begin // C
					if (x) begin
						state <= 3'b011; // B
					end else begin
						state <= 3'b010; // C
					end
				end
				3'b011: begin // D
					if (x) begin
						state <= 3'b010; // C
					end else begin
						state <= 3'b011; // D
					end
				end
				3'b100: begin // E
					if (x) begin
						state <= 3'b100; // E
					end else begin
						state <= 3'b110; // D
					end
				end
				3'b101: begin // F
					state <= 3'b110; // D
				end
				3'b110: begin // G
					state <= 3'b001; // B
				end
				3'b111: begin // H
					state <= 3'b010; // C
				end
			endcase
		end
	end

	always @(*) begin
		case (state)
			3'b010, 3'b011, 3'b100, 3'b101: begin // C, D, E, F
				z = 1'b1; // output is high when state is C, D, E or F
			end
			default: begin
				z = 1'b0;
			end
		endcase
	end
endmodule
