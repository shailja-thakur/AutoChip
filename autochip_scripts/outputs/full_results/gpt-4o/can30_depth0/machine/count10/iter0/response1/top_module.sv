module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000; // Reset q to 0 when reset is asserted
        end else if (q == 4'b1001) begin
            q <= 4'b0000; // Reset q to 0 when q equals 9
        end else begin
            q <= q + 1; // Increment q by 1 if neither reset nor q equals 9
        end
    end
endmodule
