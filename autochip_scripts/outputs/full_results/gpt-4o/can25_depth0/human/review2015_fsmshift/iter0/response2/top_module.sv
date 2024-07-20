module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    // States of the FSM
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        ENABLE_1 = 3'b001,
        ENABLE_2 = 3'b010,
        ENABLE_3 = 3'b011,
        ENABLE_4 = 3'b100
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset) begin
            state <= ENABLE_1;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: next_state = IDLE;
            ENABLE_1: next_state = ENABLE_2;
            ENABLE_2: next_state = ENABLE_3;
            ENABLE_3: next_state = ENABLE_4;
            ENABLE_4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
        end else begin
            case (state)
                IDLE: shift_ena <= 0;
                ENABLE_1: shift_ena <= 1;
                ENABLE_2: shift_ena <= 1;
                ENABLE_3: shift_ena <= 1;
                ENABLE_4: shift_ena <= 1;
                default: shift_ena <= 0;
            endcase
        end
    end
endmodule
