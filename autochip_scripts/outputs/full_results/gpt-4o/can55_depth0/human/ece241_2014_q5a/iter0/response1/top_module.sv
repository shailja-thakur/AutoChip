module top_module (
    input clk,
    input areset,
    input x,
    output reg z   // Output needs to be a register
);

    typedef enum reg {ZERO, ONE, DONE} state_t;
    state_t state, next_state;
    reg carry;

    // State transition logic
    always @(*) begin
        case(state)
            ZERO: begin
                if (x == 1)
                    next_state = ONE;
                else
                    next_state = ZERO;
            end
            ONE: begin
                if (carry)
                    next_state = DONE;
                else
                    next_state = ONE;
            end
            DONE: begin
                next_state = DONE;
            end
            default: next_state = ZERO;
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            ZERO: z = 0;
            ONE: z = ~x;
            DONE: z = z;
            default: z = 0;
        endcase
    end

    // State and carry update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= ZERO;
            carry <= 1'b1;
        end else begin
            state <= next_state;
            carry <= 0;  // Carry is zeroed since 2's complement operation should be used only once
        end
    end

endmodule
