module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define the states
    typedef enum logic [1:0] {
        BYTE1,
        BYTE2,
        BYTE3,
        DONE
    } state_type;

    // Define the current state variable
    state_type current_state;

    // Define the next state variable
    state_type next_state;

    // Define the state transitions and conditions
    always_ff @(posedge clk, posedge reset)
        if (reset)
            current_state <= BYTE1;
        else
            current_state <= next_state;

    // Define the state machine logic
    always_comb
        case (current_state)
            BYTE1: if (in[2])
                      next_state = BYTE2;
                  else
                      next_state = BYTE1;

            BYTE2: next_state = BYTE3;

            BYTE3: next_state = DONE;

            DONE: if (in[2])
                      next_state = BYTE2;
                  else
                      next_state = BYTE1;
        endcase

    // Output logic
    always_comb
        done = (current_state == DONE);

endmodule
