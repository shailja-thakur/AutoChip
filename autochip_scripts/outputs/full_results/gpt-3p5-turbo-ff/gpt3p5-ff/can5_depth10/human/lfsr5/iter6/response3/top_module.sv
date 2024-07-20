module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 1;
        else begin
            q[4] <= q[3] ^ q[2];
            q[3:0] <= {q[3:1], q[4]};
        end
    end

endmodule
