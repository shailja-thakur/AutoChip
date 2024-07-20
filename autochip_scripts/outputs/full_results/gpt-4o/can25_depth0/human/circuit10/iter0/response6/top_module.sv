module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg q_reg;

    assign q = q_reg;
    assign state = q_reg;

    always @(posedge clk) begin
        if (a == 1 && b == 1) begin
            q_reg <= !q_reg;
        end else if (a == 1 && b == 0) begin
            q_reg <= q_reg;
        end else if (a == 0 && b == 1) begin
            q_reg <= q_reg;
        end else begin
            q_reg <= 0;
        end
    end

endmodule
