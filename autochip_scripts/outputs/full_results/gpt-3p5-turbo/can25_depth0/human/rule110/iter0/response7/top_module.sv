module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[511] <= q[510] & q[511] & ~q[0];
            q[510:1] <= q[509:0] & q[510] & ~q[0];
            q[0] <= q[511] & q[0] & ~q[1];
        end
    end

endmodule
