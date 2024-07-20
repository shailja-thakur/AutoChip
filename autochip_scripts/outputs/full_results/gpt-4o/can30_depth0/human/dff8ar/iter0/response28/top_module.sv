module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    // 8 D flip-flops with active high asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b0; // Reset output to 0
        end else begin
            q <= d; // Transfer input to output on positive edge of clk
        end
    end

endmodule
