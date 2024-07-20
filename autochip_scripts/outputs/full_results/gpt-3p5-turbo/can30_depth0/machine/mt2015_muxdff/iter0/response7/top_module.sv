module top_module(
	input wire clk,
	input wire L,
	input wire q_in,
	input wire r_in,
	output reg Q);

always @(posedge clk) begin
    if (L == 1'b1) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
