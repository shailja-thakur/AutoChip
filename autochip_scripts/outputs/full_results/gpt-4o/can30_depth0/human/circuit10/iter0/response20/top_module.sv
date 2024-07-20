module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg q_reg, state_reg;
    
    always @(posedge clk) begin
        if (a & ~b) begin
            q_reg <= 1'b0;
        end else if (~a & b) begin
            q_reg <= 1'b1;
        end
    end
    
    always @(posedge clk) begin
        state_reg <= q_reg;
    end

    assign q = q_reg;
    assign state = state_reg;

endmodule
