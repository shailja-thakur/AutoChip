module top_module(
    input clk,
    input reset,
    output shift_ena
    );

    // Define state encoding
    typedef enum logic [2:0] {
        B0 = 3'b000,
        B1 = 3'b001,
        B2 = 3'b010,
        B3 = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) state <= B0;
        else       state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            B0:   next_state = B1;
            B1:   next_state = B2;
            B2:   next_state = B3;
            B3:   next_state = DONE;
            DONE: next_state = DONE;
            default: next_state = DONE;  // Should not happen, just for safety
        endcase
    end

    // Output logic
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);

endmodule
