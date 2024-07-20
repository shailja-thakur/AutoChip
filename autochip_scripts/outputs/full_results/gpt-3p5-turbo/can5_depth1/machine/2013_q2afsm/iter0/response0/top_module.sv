module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
	if (~resetn) begin
		state <= 2'b00;
	end else begin
		state <= next;
	end
end

always @(state or r) begin
	case (state)
		0: begin // State A
			if (r[2]) begin
				next <= 2'b10; // Next State C
			end else if (r[1]) begin
				next <= 2'b01; // Next State B
			end else if (r[0]) begin
				next <= 2'b11; // Next State D
			end else begin
				next <= 2'b00; // Next State A
			end
		end
		1: begin // State B
			if (r[1]) begin
				next <= 2'b01; // Next State B
			end else begin
				next <= 2'b00; // Next State A
			end
		end
		2: begin // State C
			if (r[2]) begin
				next <= 2'b10; // Next State C
			end else begin
				next <= 2'b00; // Next State A
			end
		end
		3: begin // State D
			if (r[0]) begin
				next <= 2'b11; // Next State D
			end else begin
				next <= 2'b00; // Next State A
			end
		end
	endcase
end

always @(*) begin
	case (state)
		1: begin // State B
			g[2] = 1'b1;
		end
		2: begin // State C
			g[1] = 1'b1;
		end
		3: begin // State D
			g[0] = 1'b1;
		end
		default: begin // State A
			g[2:0] = 3'b0;
		end
	endcase
end

endmodule
