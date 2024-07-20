module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1) begin
        q <= 3'd4;
    end else if (a == 0) begin
        q <= q + 1;
        if (q == 3'd6) begin
            q <= 3'd0;
        end
    end
end

endmodule
