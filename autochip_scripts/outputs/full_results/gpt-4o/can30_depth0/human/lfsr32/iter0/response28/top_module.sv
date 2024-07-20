module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 32'h1;
        else begin
            q[0] <= q[31];
            q[1] <= q[0];
            q[2] <= q[1] ^ q[31];
            q[21:3] <= q[20:2];
            q[22] <= q[21] ^ q[31];
            q[30:23] <= q[29:22];
            q[31] <= q[30] ^ q[31];
        end
    end

endmodule
