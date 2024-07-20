module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    // Define the state encoding
    typedef enum reg [2:0] {
        B0   = 3'b000,
        B1   = 3'b001,
        B2   = 3'b010,
        B3   = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;

    // State transitions
    always @(*) begin
        case(state)
            B0:   next_state = B1;
            B1:   next_state = B2;
            B2:   next_state = B3;
            B3:   next_state = DONE;
            DONE: next_state = DONE; // Stay in DONE state
            default: next_state = DONE; // Default case handles all other combinations
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B0; // Reset to initial state B0
        end else begin
            state <= next_state;
        end
    end

    // Shift enable logic
    always @(*) begin
        case(state)
            B0, B1, B2, B3: shift_ena = 1;
            default:        shift_ena = 0;
        endcase
    end

endmodule
