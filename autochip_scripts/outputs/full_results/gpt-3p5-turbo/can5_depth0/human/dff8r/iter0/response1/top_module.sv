module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

reg [7:0] q_temp;
reg [7:0] q_reg;

always @(posedge clk) begin
    if (reset) begin
        q_temp <= 8'b0;
    end else begin
        q_temp <= d;
    end
end

always @(posedge clk) begin
    if (reset) begin
        q_reg <= 8'b0;
    end else begin
        q_reg <= q_temp;
    end
end

assign q = q_reg;

endmodule
