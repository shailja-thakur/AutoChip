module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 3'b000; // State A
	end
	else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
		3'b000: next_state = (r[1]) ? 3'b001 : (r[2]) ? 3'b010 : (r[3]) ? 3'b011 : 3'b000; // State A
		3'b001: next_state = (r[1]) ? 3'b001 : 3'b000; // State B
		3'b010: next_state = (r[2]) ? 3'b010 : 3'b000; // State C
		3'b011: next_state = (r[3]) ? 3'b011 : 3'b000; // State D
		default: next_state = 3'b000; // Default to State A
	endcase
end

assign g[1] = (state == 3'b001);
assign g[2] = (state == 3'b010);
assign g[3] = (state == 3'b011);

endmodule
