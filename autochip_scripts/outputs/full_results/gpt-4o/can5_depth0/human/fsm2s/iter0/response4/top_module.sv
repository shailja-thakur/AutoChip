module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k == 1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
        endcase
    end

    // State register update logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            OFF: out = 0;
            ON: out = 1;
        endcase
    end

endmodule
