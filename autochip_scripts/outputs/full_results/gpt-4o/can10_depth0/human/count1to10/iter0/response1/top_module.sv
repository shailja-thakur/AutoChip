module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 4'd1;  // Reset counter to 1
        else if(q == 4'd10)
            q <= 4'd1;  // Wrap around to 1 after reaching 10
        else
            q <= q + 1; // Increment counter
    end

endmodule
