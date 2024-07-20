module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[31] ^ q[9] ^ q[29] ^ q[30], q[31:1]};
        end
    end

endmodule
