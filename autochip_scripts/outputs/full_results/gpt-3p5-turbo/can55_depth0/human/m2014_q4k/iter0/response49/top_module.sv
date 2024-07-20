module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] flops;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        flops <= 4'b0000;
    else
        flops <= {flops[2:0], in};
end

assign out = flops[3];

endmodule
