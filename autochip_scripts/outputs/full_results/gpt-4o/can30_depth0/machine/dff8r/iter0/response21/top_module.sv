module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Always block triggered on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // If reset is high, set q to 0
            q <= 8'b0;
        end else begin
            // Otherwise, set q to the value of d
            q <= d;
        end
    end
    
endmodule
