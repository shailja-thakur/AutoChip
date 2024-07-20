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

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;  // Active-high synchronous reset to state OFF
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            OFF: begin
                out = 1'b0;  // Output is 0 when in state OFF
                if (j == 1'b1)
                    next_state = ON;
                else
                    next_state = OFF;
            end

            ON: begin
                out = 1'b1;  // Output is 1 when in state ON
                if (k == 1'b1)
                    next_state = OFF;
                else
                    next_state = ON;
            end

            default: begin
                next_state = OFF;  // Default state (should never happen)
                out = 1'b0;
            end
        endcase
    end

endmodule
