module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state;
reg [3:1] next;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= 3'b000; // State A
	else
		state <= next;
end

always @(*) begin
	case(state)
		3'b000: begin // State A
			if (r[1])
				next = 3'b001; // State B
			else if (r[2])
				next = 3'b010; // State C
			else if (r[3])
				next = 3'b011; // State D
			else
				next = 3'b000; // State A
		end
		
		3'b001: begin // State B
			if (r[1])
				next = 3'b001; // State B
			else
				next = 3'b000; // State A
		end
		
		3'b010: begin // State C
			if (r[2])
				next = 3'b010; // State C
			else
				next = 3'b000; // State A
		end
		
		3'b011: begin // State D
			if (r[3])
				next = 3'b011; // State D
			else
				next = 3'b000; // State A
		end
	endcase
end

assign g[1] = (state == 3'b001); // State B
assign g[2] = (state == 3'b010); // State C
assign g[3] = (state == 3'b011); // State D
assign {g[2:1], g[3]} = 3'b000; // All bits low in State A

endmodule
