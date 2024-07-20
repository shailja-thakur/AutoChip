module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
	if (!resetn) begin
		state <= 2'b00; // state A
	end else begin
		state <= next_state;
	end
end

always @(state or r) begin
	case(state)
		0: begin // state A
			if (r[2]) begin
				next_state = 2'b01; // state B
			end else if (r[1]) begin
				next_state = 2'b10; // state C
			end else if (r[0]) begin
				next_state = 2'b11; // state D
			end else begin
				next_state = 2'b00; // state A
			end
		end
		1: begin // state B
			if (r[2]) begin
				next_state = 2'b01; // state B
			end else begin
				next_state = 2'b00; // state A
			end
		end
		2: begin // state C
			if (r[1]) begin
				next_state = 2'b10; // state C
			end else begin
				next_state = 2'b00; // state A
			end
		end
		3: begin // state D
			if (r[0]) begin
				next_state = 2'b11; // state D
			end else begin
				next_state = 2'b00; // state A
			end
		end
	endcase
end

always @(state) begin
	case(state)
		1: begin // state B
			g[2] = 1'b1;
		end
		2: begin // state C
			g[1] = 1'b1;
		end
		3: begin // state D
			g[0] = 1'b1;
		end
		default: begin // state A
			g = 3'b000;
		end
	endcase
end

endmodule
