module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] q;
reg [2:0] addr;

always @(posedge clk) begin
	if (enable) begin
        q <= {q[6:0], S};
    end
    addr <= {A, B, C};
    Z <= q[addr];
end

endmodule
