module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] d;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            d <= {(q[1] ^ q[21] ^ q[30]), q[31:1]};
            q <= d;
        end
    end

endmodule
