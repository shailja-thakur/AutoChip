module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    // Create 8 D flip-flops with active high asynchronous reset
    always @(posedge clk or posedge areset) begin
        // Reset condition
        if (areset) begin
            q <= 8'b0;
        end
        // Positive edge of clk
        else begin
            q <= d;
        end
    end

endmodule
