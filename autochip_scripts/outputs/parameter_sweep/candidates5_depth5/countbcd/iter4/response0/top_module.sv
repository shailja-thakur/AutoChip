module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

reg [15:0] q_next;
wire [15:0] q_reg;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		q <= 0;
		ena <= 0;
	end else begin
		q <= q_next;
		ena <= ena; // Added this line to retain the value of ena
	end
end

assign q_reg = q;

always @* begin
	q_next = q_reg + 1;

	ena[1] = (q[3:0] == 9);
	ena[2] = (q[7:4] == 9);
	ena[3] = (q[11:8] == 9);
	
	if(ena[1]) begin
		q_next[3:0] = 0;
	end
	if(ena[2]) begin
		q_next[7:4] = 0;
	end
	if(ena[3]) begin
		q_next[11:8] = 0;
	end
end

endmodule
