module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);
	reg [1:0] state;
	reg [1:0] next;

	always @(posedge clk) begin
		if (!resetn) begin
			state <= 2'b00; // A
		end else begin
			state <= next;
		end
	end
	
	always @(state or r) begin
		case(state)
			2'b00: begin // A
				if (r[2]) begin
					next = 2'b10; // C
				end else if (r[1]) begin
					next = 2'b01; // B
				end else if (r[0]) begin
					next = 2'b11; // D
				end else begin
					next = 2'b00; // A
				end
			end
			2'b01: begin // B
				if (r[1])
					next = 2'b01; // B
				else
					next = 2'b00; // A
			end
			2'b10: begin // C
				if (r[2])
					next = 2'b10; // C
				else
					next = 2'b00; // A
			end
			2'b11: begin // D
				if (r[0])
					next = 2'b11; // D
				else
					next = 2'b00; // A
			end
			default: begin
				next = 2'b00; // A
			end
		endcase
	end
	
	always @(state) begin
		case(state)
			2'b01: begin // B
				g[2] = 1'b1;
			end
			2'b10: begin // C
				g[1] = 1'b1;
			end
			2'b11: begin // D
				g[0] = 1'b1;
			end
			default: begin
				g = 3'b000;
			end
		endcase
	end
endmodule
