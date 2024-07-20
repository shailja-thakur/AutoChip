module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);
    reg state_reg;

    always @(posedge clk) begin
        state_reg <= (a & b) ? ~state_reg : state_reg;
        q <= state_reg;
    end

    assign state = state_reg;

endmodule
