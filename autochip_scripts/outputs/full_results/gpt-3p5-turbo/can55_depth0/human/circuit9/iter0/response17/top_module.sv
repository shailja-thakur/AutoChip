module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 0) begin
        q <= 0;
    end else if (q == 5) begin
        q <= 6;
    end else if (q == 6) begin
        q <= 0;
    end else begin
        q <= q + 1;
    end
end

endmodule
