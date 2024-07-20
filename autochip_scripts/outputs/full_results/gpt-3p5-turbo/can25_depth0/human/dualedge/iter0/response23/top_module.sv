module top_module(
    input clk,
    input d,
    output reg q);

    reg q_reg;
    reg q_next;

    always @(posedge clk) begin
        q_reg <= q_next;
    end

    always @(posedge clk) begin
        q_next <= d;
    end

    always @(negedge clk) begin
        q <= q_reg;
    end

endmodule
