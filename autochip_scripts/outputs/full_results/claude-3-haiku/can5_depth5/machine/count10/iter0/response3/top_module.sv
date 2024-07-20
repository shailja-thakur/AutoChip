module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset || q == 4'b1001) // Compare q to 9 (binary 1001)
            q <= 4'b0000; // Reset q to 0
        else
            q <= q + 1'b1; // Increment q
    end

endmodule
