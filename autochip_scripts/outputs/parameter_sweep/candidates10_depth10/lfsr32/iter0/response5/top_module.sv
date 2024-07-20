module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;
        else begin
            q[0] <= q[1] ^ q[2] ^ q[21] ^ q[31];
            q[1:31] <= q[0:30];
        end
    end

endmodule
