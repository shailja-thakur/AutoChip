module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);

    reg state_reg;

    always @(posedge clk) begin
        if (a && b) begin
            state_reg <= ~state_reg;
        end else if (b) begin
            state_reg <= 1;
        end else begin
            state_reg <= 0;
        end
        
        q <= state_reg;
    end

    assign state = state_reg;

endmodule
