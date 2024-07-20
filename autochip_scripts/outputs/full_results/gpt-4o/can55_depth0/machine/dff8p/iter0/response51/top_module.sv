module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Always block, triggered on the negative edge of the clock signal
    always @(negedge clk) begin
        if (reset) begin
            q <= 8'h34; // Set q to 0x34 (hexadecimal) if reset is asserted
        end else begin
            q <= d; // Store the value of d in q if reset is not asserted
        end
    end

endmodule
