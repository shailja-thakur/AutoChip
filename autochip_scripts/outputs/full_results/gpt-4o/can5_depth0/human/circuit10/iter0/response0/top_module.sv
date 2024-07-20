module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);
    reg state_reg;

    assign state = state_reg;

    always @(posedge clk) begin
        // The flip-flop updates its output based on input 'a' and 'b' at the rising edge of the clock
        if (a == 1'b0 && b == 1'b1) begin
            state_reg <= 1'b0;
            q <= 1'b0;
        end
        else if (a == 1'b1 && b == 1'b0) begin
            state_reg <= 1'b0;
            q <= 1'b1;
        end
        else if (a == 1'b1 && b == 1'b1) begin
            state_reg <= 1'b1;
            q <= 1'b1;
        end
        else begin // a == 1'b0 && b == 1'b0
            state_reg <= state_reg;
            q <= state_reg;
        end
    end

endmodule
