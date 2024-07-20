module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] d;
    reg [31:0] next_q;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            d <= q;
            next_q = {d[1] ^ d[21] ^ d[31], d[31:1]};
            q <= next_q;
        end
    end

endmodule
