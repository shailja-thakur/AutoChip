module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0000000000; // Reset q to 0
        end else begin
            if (q == 10'd999) begin
                q <= 10'b0000000000; // Reset q to 0 when it reaches 999
            end else begin
                q <= q + 1'b1; // Increment q by 1
            end
        end
    end
endmodule
