module top_module(
    input clk,
    input reset,
    output shift_ena
    );

    // State Declarations
    typedef enum logic [2:0] {
        B0 = 3'b000,
        B1 = 3'b001,
        B2 = 3'b010,
        B3 = 3'b011,
        Done = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= B0;
        else
            current_state <= next_state;
    end

    // State Transition Logic
    always_comb begin
        case (current_state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            Done: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // Output Logic
    assign shift_ena = (current_state == B0) || 
                       (current_state == B1) || 
                       (current_state == B2) || 
                       (current_state == B3);

endmodule
