module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic (Moore state machine)
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    // Output logic (Moore machine output depends only on state)
    always @(posedge clk) begin
        if (reset)
            out <= 1'b0;
        else begin
            case (state)
                OFF: out <= 1'b0;
                ON:  out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end

endmodule
