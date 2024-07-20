module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);
    
    // Initial reset value is 0x34 (00110100)
    reg [7:0] reset_value = 8'h34;

    always @(negedge clk) begin
        if (reset) begin
            q <= reset_value;
        end else begin
            q <= d;
        end
    end
endmodule
