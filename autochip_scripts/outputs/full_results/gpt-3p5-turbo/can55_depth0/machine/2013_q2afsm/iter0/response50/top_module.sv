module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);
	reg [1:0] state;
	reg [1:0] next;

	always @(posedge clk) begin
		if (~resetn) begin
			state <= 2'b0;
		end else begin
			state <= next;
		end
	end

	always @(state or r) begin
		case(state)
			2'b00: begin // State A
				if (r[2]) begin
					next <= 2'b10; // State C
				end else if(r[3]) begin
					next <= 2'b11; // State D
				end else if(r[1]) begin
					next <= 2'b01; // State B
				end else begin
					next <= 2'b00; // State A
				end
			end

			2'b01: begin // State B
				if(r[1]) begin
					next <= 2'b01; // State B
				end else begin
					next <= 2'b00; // State A
				end
			end

			2'b10: begin // State C
				if(r[2]) begin
					next <= 2'b10; // State C
				end else begin
					next <= 2'b00; // State A
				end
			end

			2'b11: begin // State D
				if(r[3]) begin
					next <= 2'b11; // State D
				end else begin
					next <= 2'b00; // State A
				end
			end
		endcase
	end

	always @(state) begin
		case(state)
			2'b01: begin // State B
				g[1] <= 1'b1;
				g[2] <= 1'b0;
				g[3] <= 1'b0;
			end

			2'b10: begin // State C
				g[1] <= 1'b0;
				g[2] <= 1'b1;
				g[3] <= 1'b0;
			end

			2'b11: begin // State D
				g[1] <= 1'b0;
				g[2] <= 1'b0;
				g[3] <= 1'b1;
			end

			default: begin // State A
				g[1] <= 1'b0;
				g[2] <= 1'b0;
				g[3] <= 1'b0;
			end
		endcase
	end

endmodule
