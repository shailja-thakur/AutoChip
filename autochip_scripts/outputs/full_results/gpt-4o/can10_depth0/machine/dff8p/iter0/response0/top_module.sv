module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'h34; // Set q to 0x34 if reset is asserted
        end
        else begin
            q <= d;     // Otherwise set q to the value of d
        end
    end

endmodule
