module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

	reg [63:0] q_temp;

	always @(posedge clk) begin
		if (load) begin
			q_temp <= {q[62:0], 1'b0};
		end else if (ena) begin
			case (amount)
				2'b00: q_temp <= {q[62:0], 1'b0};
				2'b01: q_temp <= {56'b0, q[63:8]};
				2'b10: q_temp <= {q[63], q[63:1]};
				2'b11: q_temp <= {8{q[63]}, q[63:0]};
				default: q_temp <= 64'hx;
			endcase
		end
	end
	
	always @(posedge clk) begin
		q <= q_temp;
	end
	
endmodule
