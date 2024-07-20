module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State Encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Detected '1'
        S2 = 2'b10  // Detected '10'
    } state_t;

    // State and next state variables
    state_t state, next_state;

    // FSM state transition and output logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
            z <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                S2: z <= (x == 1);
                default: z <= 0;
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: begin
                if (x) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (x) next_state = S1;
                else next_state = S2;
            end
            S2: begin
                if (x) next_state = S1;
                else next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
