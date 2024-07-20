module top_module (
    input clk,
    input reset,
    output reg shift_ena
);

    // Define the states
    typedef enum logic [3:0] {
        IDLE    = 4'b0000,
        SHIFT_1 = 4'b0001,
        SHIFT_2 = 4'b0010,
        SHIFT_3 = 4'b0011,
        SHIFT_4 = 4'b0100,
        DONE    = 4'b0101
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) 
            state <= SHIFT_1; // Directly go to SHIFT_1 on reset
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            SHIFT_1: next_state = SHIFT_2;
            SHIFT_2: next_state = SHIFT_3;
            SHIFT_3: next_state = SHIFT_4;
            SHIFT_4: next_state = DONE;
            DONE:    next_state = DONE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) 
            shift_ena <= 1'b1; // Assert shift_ena on reset
        else begin
            case (state)
                SHIFT_1, SHIFT_2, SHIFT_3, SHIFT_4: shift_ena <= 1'b1;
                DONE: shift_ena <= 1'b0;
                default: shift_ena <= 1'b0;
            endcase
        end
    end

endmodule
