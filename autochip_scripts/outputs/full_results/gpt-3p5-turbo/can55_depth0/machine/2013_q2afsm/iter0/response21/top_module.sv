module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00;     // Set initial state to A
	end else begin
		state <= next;      // Update state with next state
	end
end

always @* begin
	case (state)
		2'b00: begin  // A
			if (r[1]) begin
				next = 2'b01;    // B
			end else if (r[2]) begin
				next = 2'b10;    // C
			end else if (r[3]) begin
				next = 2'b11;    // D
			end else begin
				next = 2'b00;    // A
			end
		end
		2'b01: begin  // B
			if (r[1]) begin
				next = 2'b01;    // B
			end else begin
				next = 2'b00;    // A
			end
		end
		2'b10: begin  // C
			if (r[2]) begin
				next = 2'b10;    // C
			end else begin
				next = 2'b00;    // A
			end
		end
		2'b11: begin  // D
			if (r[3]) begin
				next = 2'b11;    // D
			end else begin
				next = 2'b00;    // A
			end
		end
	endcase
end

assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0;
assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0;
assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
