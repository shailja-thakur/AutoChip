module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end
        else begin
            q[31] <= q[0];
            q[30:23] <= q[31:22];
            q[22] <= q[0] ^ q[22];
            q[21:3] <= q[30:12];
            q[2] <= q[0] ^ q[2];
            q[1] <= q[0] ^ q[1];
            q[0] <= q[0];
        end
    end

endmodule
