module top_module( input clk, input reset, output reg [4:0] q);

// Internal signals
reg [4:0] q_next;
reg [4:0] q_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		q_reg <= 1;
	end else begin
		q_reg <= q_next;
	end
end

always @* begin
	q_next = {q_reg[3]^q_reg[4]^q_reg[2], q_reg[4], q_reg[3], q_reg[2], q_reg[1]};
end

assign q = q_reg;

endmodule
