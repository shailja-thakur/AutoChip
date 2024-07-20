module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0001;  // Reset q to 1
        else if (q == 4'b1010)  // When q reaches 10
            q <= 4'b0001;  // Reset q to 1
        else
            q <= q + 1;  // Increment q by 1
    end

endmodule
