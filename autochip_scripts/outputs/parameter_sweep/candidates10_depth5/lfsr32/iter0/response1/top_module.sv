module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 32'h1;
        else begin
            q[0] <= q[31] ^ q[21] ^ q[1];
            q[1] <= q[0];
            q[2:31] <= q[1:30];
        end
    end

endmodule
