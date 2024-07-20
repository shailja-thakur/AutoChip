module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge
);

reg [7:0] previous_in;

always @(posedge clk) begin
    previous_in <= in;

    for (integer i = 0; i <= 7; i = i + 1) begin
        if (in[i] && !previous_in[i]) begin
            pedge[i] <= 1'b1;
        end else begin
            pedge[i] <= 1'b0;
        end
    end
end

endmodule
