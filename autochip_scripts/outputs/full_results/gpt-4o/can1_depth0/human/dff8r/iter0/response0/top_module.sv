module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0; // Active high synchronous reset
        end else begin
            q <= d; // Store data on positive edge of clock
        end
    end

endmodule
