module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_reg;

    always @(posedge clk, negedge clk) begin
        if (clk) begin
            q_reg <= d;
        end
    end

    always @(posedge clk, negedge clk) begin
        q <= q_reg;
    end

endmodule
