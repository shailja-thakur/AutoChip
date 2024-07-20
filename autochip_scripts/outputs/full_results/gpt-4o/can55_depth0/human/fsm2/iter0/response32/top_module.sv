module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define states
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j) next_state = ON;
                else next_state = OFF;
            end
            ON: begin
                if (k) next_state = OFF;
                else next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    // Output logic (Moore)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 0;
        end else begin
            case (state)
                OFF: out <= 0;
                ON: out <= 1;
                default: out <= 0;
            endcase
        end
    end

endmodule
