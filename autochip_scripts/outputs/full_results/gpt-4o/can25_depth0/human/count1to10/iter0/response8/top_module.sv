module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;  // Reset to 1
        end
        else begin
            if (q == 4'b1010) begin  // When count reaches 10
                q <= 4'b0001;  // Reset to 1
            end
            else begin
                q <= q + 1;  // Increment counter
            end
        end
    end

endmodule
