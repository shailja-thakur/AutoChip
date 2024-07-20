module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1'b1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k == 1'b1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF; // Defensive coding
        endcase
    end

    // State register (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic (Moore)
    always @(posedge clk) begin
        if (reset)
            out <= 1'b0;
        else begin
            case (state)
                OFF: out <= 1'b0;
                ON : out <= 1'b1;
            endcase
        end
    end
endmodule
