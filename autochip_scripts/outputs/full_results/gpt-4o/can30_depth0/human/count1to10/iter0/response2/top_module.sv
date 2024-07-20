module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // Reset the counter to 1
        end 
        else if (q == 4'd10) begin
            q <= 4'b0001; // After reaching 10, reset the counter to 1
        end 
        else begin
            q <= q + 1; // Increment the counter
        end
    end
endmodule
