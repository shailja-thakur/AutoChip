module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum reg {
        S0 = 1'b0, // Initial state
        S1 = 1'b1  // Flipping bits state
    } state_t;

    // State variables
    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S0: begin
                // The first incoming bit should not be complemented, hence proceed to next state
                next_state = S1;
            end
            S1: begin
                // Stay in the S1 state
                next_state = S1;
            end
            default: next_state = S0; // Default state
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0; // Definition for reset output
        end else begin
            case (state)
                S0: z <= x;     // First incoming bit should be output as it is
                S1: z <= ~x;    // Complement the incoming bit
            endcase
        end
    end

endmodule
