module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define states
    typedef enum logic [3:0] {
        S,
        S1,
        S10
    } state_t;

    // Define signals
    reg state;           // Current state
    reg next_state;      // Next state

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S;   // Initial state
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always_comb begin
        case (state)
            S:
                z = 0;
            S1:
                z = 0;
            S10:
                z = x;
            default:
                z = 0;
        endcase
    end

    // Next state logic
    always_comb begin
        case ({x, state})
            2'b00:
                next_state = S;
            2'b01:
                next_state = S1;
            2'b10:
                next_state = S10;
            default:
                next_state = S;  // Default to S state
        endcase
    end

endmodule
