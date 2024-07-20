module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0001; // set output register to 1
        else if (q == 4'b1010)
            q <= 4'b0001; // reset output register to 1
        else
            q <= q + 1; // increment output register by one
    end

endmodule
