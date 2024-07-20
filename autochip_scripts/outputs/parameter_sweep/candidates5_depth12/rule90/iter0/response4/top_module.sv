module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q
);
// Initialize boundary cells as zero
reg [511:0] q_temp;
always @(*) begin
    q_temp[0] = 0;
    q_temp[511] = 0;
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q_temp[1:510] = q[0:509];
        q[0:511] = {q_temp[1],q_temp[0:510]};
    end
end

endmodule
