module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] d;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            d <= q;
            q <= {d[1] ^ d[21] ^ d[31] ^ q[0], d[31:1]};
        end
    end

endmodule
