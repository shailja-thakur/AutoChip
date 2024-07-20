module top_module (
    input clk,
    input reset,
    output reg shift_ena
);

    // Define the states
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        ENABLE_1 = 3'b001,
        ENABLE_2 = 3'b010,
        ENABLE_3 = 3'b011,
        ENABLE_4 = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= ENABLE_1; // Directly go to ENABLE_1 on reset
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            ENABLE_1: next_state = ENABLE_2;
            ENABLE_2: next_state = ENABLE_3;
            ENABLE_3: next_state = ENABLE_4;
            ENABLE_4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1'b1; // Assert shift_ena on reset
        else begin
            case (state)
                ENABLE_1, ENABLE_2, ENABLE_3, ENABLE_4: shift_ena <= 1'b1;
                IDLE: shift_ena <= 1'b0;
                default: shift_ena <= 1'b0;
            endcase
        end
    end

endmodule
