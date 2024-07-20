module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0;  // Reset output register to 0
        end else begin
            if (q == 10'd999) begin
                q <= 10'b0;  // Reset the count when reaching 999
            end else begin
                q <= q + 1'b1;  // Increment the count
            end
        end
    end

endmodule
