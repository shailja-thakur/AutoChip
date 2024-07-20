module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define state encoding using parameters
    parameter OFF = 1'b0;
    parameter ON  = 1'b1;

    // Current state and next state variables
    reg state, next_state;
    
    // State transition logic (Moore Machine)
    always @(*) begin
        case (state)
            OFF: begin
                out = 1'b0;
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                out = 1'b1;
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: begin
                next_state = OFF;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
endmodule
