module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0, // State 0: default state
        S1, // State 1: inverting phase
        S2  // State 2: after inversion is done
    } state_t;
    
    state_t state, next_state;
    logic inversion_flag;

    // State transition
    always_ff @(posedge clk, posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    // Moore Output Logic
    always_ff @(posedge clk, posedge areset) begin
        if (areset)
            z <= 0;  // Define output during reset
        else begin
            case (state)
                S1:
                    z <= ~x;  // Inverting phase
                S2:
                    z <= 0;   // Hold after inversion
                default:
                    z <= 0;   // Default case, usually state S0
            endcase
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;  // Default to hold state
        case (state)
            S0: begin
                if (!areset)
                    next_state = S1;  // Start inverting on reset release
            end
            S1: begin
                if (areset)
                    next_state = S2;  // Stop inverting when reset is asserted
            end
            S2: begin
                if (!areset)
                    next_state = S0;  // Return to initial state when reset is released
            end
        endcase
    end

endmodule
