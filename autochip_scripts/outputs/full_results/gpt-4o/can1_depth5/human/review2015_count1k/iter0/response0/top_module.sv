module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 10'd0;
        else if (q == 10'd999)
            q <= 10'd0;
        else
            q <= q + 10'd1;
    end

endmodule
