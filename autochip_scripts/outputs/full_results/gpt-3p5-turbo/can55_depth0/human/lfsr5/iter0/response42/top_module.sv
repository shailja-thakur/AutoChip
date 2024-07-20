module top_module(
	input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1;
        else begin
            q <= {q[3] ^ q[4], q[0], q[1], q[2], q[3]};
        end
    end
endmodule
