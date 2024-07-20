module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    typedef enum logic [2:0] {
        B0   = 3'b000,
        B1   = 3'b001,
        B2   = 3'b010,
        B3   = 3'b011,
        Done = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= B0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            B0:   next_state = B1;
            B1:   next_state = B2;
            B2:   next_state = B3;
            B3:   next_state = Done;
            Done: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            B0, B1, B2, B3: shift_ena = 1;
            default:        shift_ena = 0;
        endcase
    end

endmodule
