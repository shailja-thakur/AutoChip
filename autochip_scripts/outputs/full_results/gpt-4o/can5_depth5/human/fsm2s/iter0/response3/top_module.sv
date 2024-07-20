module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic
    always @(*) begin
        case (current_state)
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
                out = 1'b0;
                next_state = OFF;
            end
        endcase
    end

    // Synchronous state transition and reset
    always @(posedge clk) begin
        if (reset)
            current_state <= OFF;
        else
            current_state <= next_state;
    end

endmodule
