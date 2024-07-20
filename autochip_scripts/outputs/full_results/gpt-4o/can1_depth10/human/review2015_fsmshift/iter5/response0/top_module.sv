module top_module (
    input clk,
    input reset,
    output reg shift_ena
);

    // Define the states
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        SHIFT_1 = 3'b001,
        SHIFT_2 = 3'b010,
        SHIFT_3 = 3'b011,
        SHIFT_4 = 3'b100,
        DONE    = 3'b101
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
            IDLE:    next_state = IDLE;
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
