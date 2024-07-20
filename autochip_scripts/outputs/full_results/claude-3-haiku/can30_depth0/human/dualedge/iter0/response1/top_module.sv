module top_module(
    input clk,
    input d,
    output reg q
);

    reg clk_prev;

    always @(posedge clk) begin
        clk_prev <= clk;
        if (clk_prev ^ clk) begin
            q <= d;
        end
    end

endmodule
