module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] reg;
wire [3:0] reg_next;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		reg <= 4'b0;
	end else begin
		reg <= reg_next;
	end
end

assign reg_next[0] = in;
assign reg_next[1] = reg[0];
assign reg_next[2] = reg[1];
assign reg_next[3] = reg[2];

assign out = reg[3];

endmodule
