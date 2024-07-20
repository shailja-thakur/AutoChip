module top_module (
    input clk,
    input reset,
    output reg [3:0] q
);

    // Always block that triggers on the rising edge of the clock signal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the counter to 0 if reset is asserted
            q <= 4'b0000;
        end else begin
            // Increment the counter by 1 if reset is not asserted
            q <= q + 1;
        end
    end

endmodule
