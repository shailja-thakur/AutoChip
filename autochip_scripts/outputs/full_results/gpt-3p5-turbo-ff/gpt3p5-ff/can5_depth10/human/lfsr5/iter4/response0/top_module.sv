module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 1;
        else
            q <= {q[3] ^ q[0], q[4:1]};
    end

endmodule
