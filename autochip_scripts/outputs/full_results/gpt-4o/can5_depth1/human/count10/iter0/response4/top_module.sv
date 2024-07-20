module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end
        else if (q == 4'd9) begin
            q <= 4'b0000; // Reset to 0 after reaching 9
        end
        else begin
            q <= q + 4'b0001; // Increment the counter
        end
    end
endmodule
