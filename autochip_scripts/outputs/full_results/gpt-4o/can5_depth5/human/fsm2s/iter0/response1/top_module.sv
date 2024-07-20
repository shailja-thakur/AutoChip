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

    // State transition logic
    always @(*) begin
        case (state)
            OFF: if (j) 
                    next_state = ON;
                 else 
                    next_state = OFF;
            ON: if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            default: 
                next_state = OFF; // should never happen
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b0; // reset output on reset
        else
            out <= (state == ON) ? 1'b1 : 1'b0;
    end
endmodule
