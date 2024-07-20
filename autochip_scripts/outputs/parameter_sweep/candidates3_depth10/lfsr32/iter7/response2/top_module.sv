module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] d;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            d <= {q[30:0],(q[0] ^ q[1] ^ q[21] ^ q[31])};
            q <= d;
        end
    end

endmodule
