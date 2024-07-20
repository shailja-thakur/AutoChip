module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON: next_state = k ? OFF : ON;
        endcase
    end

    // State register (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Output logic (Moore)
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
        endcase
    end

endmodule
