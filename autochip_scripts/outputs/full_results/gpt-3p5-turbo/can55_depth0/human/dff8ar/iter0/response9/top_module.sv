module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);

    // Declare 8 flip-flops
    reg [7:0] q_ff [7:0];

    // Synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            q <= 8'b0;
            q_ff <= 8'b0;
        end
        else begin
            q <= q_ff;
            q_ff <= d;
        end
    end

endmodule
