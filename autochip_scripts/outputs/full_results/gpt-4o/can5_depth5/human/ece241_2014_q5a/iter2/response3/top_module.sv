module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Flipping state
        S2 = 2'b10  // Adding 1 state
    } state_t;

    state_t state, next_state;
    reg carry; // To manage carry during addition

    // State transition on clock edge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            carry <= 1'b0;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = S1; // Start complementing
            S1: next_state = S2; // Move to adding 1 state
            S2: next_state = S2; // Stay in the adding 1 state
            default: next_state = S0;
        endcase
    end

    // Output and carry logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            carry <= 1'b0;
        end else begin
            case (state)
                S0: begin
                    z <= 1'b0;
                end
                S1: begin
                    z <= ~x; // Invert the input x
                    carry <= 1'b1; // Initialize carry for adding 1
                end
                S2: begin
                    z <= z ^ carry; // Add carry to inverted bit
                    carry <= z & carry; // Update carry for next bit addition
                end
            endcase
        end
    end

endmodule
