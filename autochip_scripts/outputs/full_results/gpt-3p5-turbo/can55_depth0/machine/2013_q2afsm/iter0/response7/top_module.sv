module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [1:0] state;
	reg [1:0] next;
    
	always @(posedge clk) begin
		if (resetn == 0) begin
			state <= 2'b00;
		end else begin
			state <= next;
		end
	end
  
	always @(state or r) begin
		case (state)
			2'b00: begin // State A
				if (r[1] == 1) begin
					next = 2'b01; // State B
				end else if (r[2] == 1) begin
					next = 2'b10; // State C
				end else if (r[3] == 1) begin
					next = 2'b11; // State D
				end else begin
					next = 2'b00; // State A
				end
			end
			2'b01: begin // State B
				if (r[1] == 1) begin
					next = 2'b01; // State B
				end else begin
					next = 2'b00; // State A
				end
			end
			2'b10: begin // State C
				if (r[2] == 1) begin
					next = 2'b10; // State C
				end else begin
					next = 2'b00; // State A
				end
			end
			2'b11: begin // State D
				if (r[3] == 1) begin
					next = 2'b11; // State D
				end else begin
					next = 2'b00; // State A
				end
			end
			default: next = 2'b00; // State A (default)
		endcase
	end
  
	always @(state) begin
		case (state)
			2'b01: g[1] = 1; // State B
			2'b10: g[2] = 1; // State C
			2'b11: g[3] = 1; // State D
			default: g = 'b0; // All bits low (default)
		endcase
	end

endmodule
