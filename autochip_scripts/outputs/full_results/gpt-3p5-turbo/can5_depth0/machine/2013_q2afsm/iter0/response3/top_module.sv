module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
	if (!resetn) begin
		state <= 2'b00; // state A
	end else begin
		state <= next;
	end
end

always @* begin
	case(state)
		0: begin // state A
			if (r[2]) begin
  				next = 2'b01; // state B
			end else if (r[1]) begin
				next = 2'b10; // state C
			end else if (r[0]) begin
				next = 2'b11; // state D
			end else begin
				next = 2'b00; // state A
			end
		end
		1: begin // state B
			if (r[2]) begin
  				next = 2'b01; // state B
			end else begin
				next = 2'b00; // state A
			end
		end
		2: begin // state C
			if (r[1]) begin
  				next = 2'b10; // state C
			end else begin
				next = 2'b00; // state A
			end
		end
		3: begin // state D
			if (r[0]) begin
  				next = 2'b11; // state D
			end else begin
				next = 2'b00; // state A
			end
		end
	endcase
end

always @* begin
	case(state)
		1: g[2] = 1'b1;
		2: g[1] = 1'b1;
		3: g[0] = 1'b1;
		default: g = 3'b0;
	endcase
end

endmodule
