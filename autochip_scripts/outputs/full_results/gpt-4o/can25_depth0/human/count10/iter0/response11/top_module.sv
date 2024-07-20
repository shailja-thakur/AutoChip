module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // sequential block to update the counter
    always @(posedge clk) begin
        if (reset)
            q <= 4'b0000; // reset counter to 0
        else if (q == 4'b1001)
            q <= 4'b0000; // wrap around to 0 after counting to 9
        else
            q <= q + 1; // increment the counter
    end

endmodule
