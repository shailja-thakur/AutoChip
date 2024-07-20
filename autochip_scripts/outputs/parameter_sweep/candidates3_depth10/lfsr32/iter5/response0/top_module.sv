module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] d;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            d[0] <= d[22] ^ d[2] ^ d[0] ^ d[1];
            d[31:1] <= q[30:0];
            q <= d;
        end
    end

endmodule
