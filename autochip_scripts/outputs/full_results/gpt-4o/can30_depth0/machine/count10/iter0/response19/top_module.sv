module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the positive edge of the clock signal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the counter to 0 if reset is asserted
            q <= 4'b0000;
        end else if (q == 4'd9) begin
            // Reset the counter to 0 if the count reaches 9
            q <= 4'b0000;
        end else begin
            // Increment the counter by 1
            q <= q + 1;
        end
    end

endmodule
