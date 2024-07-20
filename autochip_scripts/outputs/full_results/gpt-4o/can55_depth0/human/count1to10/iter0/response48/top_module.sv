module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'd1; // Reset the counter to 1 on reset
        end else begin
            // Counting from 1 to 10 (1 to 4'd10)
            if (q == 4'd10) begin
                q <= 4'd1; // Wrap around to 1 after 10
            end else begin
                q <= q + 4'd1; // Increment the counter
            end
        end
    end
    
endmodule
