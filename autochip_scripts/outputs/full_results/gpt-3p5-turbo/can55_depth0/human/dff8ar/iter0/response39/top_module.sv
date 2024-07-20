module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    reg [7:0] q_next;

    always @(posedge clk, posedge areset) begin
        if (areset)
            q_next <= 8'b0;
        else
            q_next <= d;
    end

    always @(posedge clk) begin
        if (~areset)
            q <= q_next;
    end
endmodule
