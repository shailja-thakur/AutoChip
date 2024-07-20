module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[30] ^ q[20] ^ q[1] ^ q[0], q[31:1]};
        end
    end

endmodule
