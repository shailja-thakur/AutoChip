module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk) begin
		if (resetn == 0) begin
			state <= 3'b001;
		end else begin
			state <= next;
		end
	end
	
	always @(state or r) begin
		case(state)
			3'b001: begin
				if (r[1] == 1) begin
					next = 3'b010;
				end else if (r[2] == 1) begin
					next = 3'b011;
				end else if (r[3] == 1) begin
					next = 3'b100;
				end else begin
					next = 3'b001;
				end
			end
			3'b010: begin
				if (r[1] == 1) begin
					next = 3'b010;
				end else begin
					next = 3'b001;
				end
			end
			3'b011: begin
				if (r[2] == 1) begin
					next = 3'b011;
				end else begin
					next = 3'b001;
				end
			end
			3'b100: begin
				if (r[3] == 1) begin
					next = 3'b100;
				end else begin
					next = 3'b001;
				end
			end
		endcase
	end
	
	always @(state) begin
		case(state)
			3'b010: g[1] = 1;
			3'b011: g[2] = 1;
			3'b100: g[3] = 1;
			default: g = 3'b000;
		endcase
	end
endmodule
