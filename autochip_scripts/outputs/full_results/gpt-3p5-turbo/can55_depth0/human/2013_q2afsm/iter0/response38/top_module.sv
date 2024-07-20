module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
 
// State declaration
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
 
// Internal signal declaration
reg [1:0] state;
reg [3:1] g_int;
 
// Output assignment
assign g = g_int;
 
// State table
always @ (posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		case (state)
			A: begin
				if (r[1] == 1) begin
					state <= B;
				end else if (r[2] == 1) begin
					state <= C;
				end else if (r[3] == 1) begin
					state <= D;
				end else begin
					state <= A;
				end
			end
			B: begin
				if (r[1] == 1 && g_int[1] == 1) begin
					state <= B;
				end else if (r[1] == 0) begin
					state <= A;
				end
			end
			C: begin
				if (r[2] == 1 && g_int[2] == 1) begin
					state <= C;
				end else if (r[2] == 0) begin
					state <= A;
				end
			end
			D: begin
				if (r[1] == 0 && r[2] == 0 && r[3] == 0) begin
					state <= A;
				end
			end
		endcase
	end
end
 
// State flip-flops
always @ (posedge clk or negedge resetn) begin
	if (~resetn) begin
		g_int <= 0;
	end else begin
		if (state == B && r[1] == 1) begin
			g_int[1] <= 1;
		end else if (state == C && r[2] == 1) begin
			g_int[2] <= 1;
		end else begin
			g_int <= 0;
		end
	end
end
 
endmodule
