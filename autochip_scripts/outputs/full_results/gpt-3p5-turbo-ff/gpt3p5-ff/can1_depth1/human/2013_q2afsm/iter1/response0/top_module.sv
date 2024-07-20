module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
reg [3:1] g_int;
wire [3:1] r_int;

// Intermediate signal that combines all the request signals
assign r_int = r[3] & r[2] & r[1];

// State definitions
localparam A = 3'b000;
localparam B = 3'b001;
localparam C = 3'b010;
localparam D = 3'b011;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= A;
	else
		state <= next_state;
end

always @* begin
	case(state)
		A: begin
			if (r_int) begin
				if (r[1])
					next_state = B;
				else if (r[2])
					next_state = C;
				else if (r[3])
					next_state = D;
			end else
				next_state = A;
		end
		B: begin
			if (r[1])
				next_state = B;
			else if (r_int)
				next_state = A;
		end
		C: begin
			if (r[2])
				next_state = C;
			else if (r_int)
				next_state = A;
		end
		D: begin
			if (r[3])
				next_state = D;
			else if (r_int)
				next_state = A;
		end
	endcase
end

always @(posedge clk) begin
	case(state)
		A: g_int = 3'b000;
		B: g_int = 3'b100;
		C: g_int = 3'b010;
		D: g_int = 3'b001;
	endcase
end

assign g = g_int;

endmodule
