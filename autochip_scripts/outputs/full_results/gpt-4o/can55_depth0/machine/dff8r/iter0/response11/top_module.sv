module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Always block triggered by the rising edge of the clock
    always @(posedge clk) begin
        // Check if reset input is high
        if (reset)
            q <= 0;        // Set output to 0 if reset is high
        else
            q <= d;        // Store the value of data input if reset is low
    end

endmodule
