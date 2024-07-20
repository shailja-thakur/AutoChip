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
    reg flip; // Register to store if we should flip bits or not

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            flip <= 1'b0; // Reset the flip signal
        end else begin
            state <= next_state;
            if (state == S0) begin
                flip <= 1'b1; // Start flipping after reset
            end
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S0: next_state = S1; // Move to flip state
            S1: next_state = S1; // Stay in the flip state
            default: next_state = S0; // Default state
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else if (flip) begin
            z <= ~x;   // Complement the incoming bit
        end else begin
            z <= x;    // Pass the bit as it is
        end
    end

endmodule
