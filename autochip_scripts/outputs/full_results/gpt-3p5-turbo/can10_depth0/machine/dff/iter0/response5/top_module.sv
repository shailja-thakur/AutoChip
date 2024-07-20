module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_reg;

    always @(posedge clk) begin
        q_reg <= d;
    end

    initial begin
        q_reg = 1'hx;
    end

    assign q = q_reg;

endmodule
