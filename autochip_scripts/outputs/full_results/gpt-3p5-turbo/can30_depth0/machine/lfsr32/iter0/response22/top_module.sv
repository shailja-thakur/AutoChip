module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 32'b1;
        else begin
            q[0] <= q[31];
            q[1] <= q[0] ^ q[1];
            q[21] <= q[0] ^ q[21];
            q[31:2] <= q[30:1];
        end
    end
endmodule
