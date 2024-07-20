module top_module (
    input clk,
    input reset,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;  // Reset q to 0
        end else if (q == 4'b1001) begin
            q <= 4'b0000;  // Reset q to 0 if it is 9 (1001)
        end else begin
            q <= q + 4'd1;  // Increment q by 1
        end
    end

endmodule
