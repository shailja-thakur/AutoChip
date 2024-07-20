module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 10'b0;
        else if (q == 9'b111110100) // check if the counter has reached 999
            q <= 10'b0;
        else
            q <= q + 1;
    end
endmodule
