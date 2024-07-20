module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum logic {
        S0, // Initial state
        S1  // Flipping bits state
    } state_t;

    // State variables
    state_t state, next_state;

    // Flip-flop to track if the 2's complement process has started
    reg flip_started;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            flip_started <= 1'b0;
        end 
        else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S0: next_state = S1; // Move to flip state after reset
            S1: next_state = S1; // Remain in flipping state
            default: next_state = S0; // Default case
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            flip_started <= 1'b0;
        end 
        else begin
            case (state)
                S0: begin
                    z <= 1'b0; // Initialize output to 0
                end
                S1: begin
                    if (!flip_started) begin
                        z <= ~x; // Flip the bit and start the 2's complement
                        flip_started <= 1'b1;
                    end 
                    else begin
                        z <= ~x + 1'b1; // Add 1 to the negated bits
                        flip_started <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
