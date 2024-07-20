module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Declare the state variables
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Subtract one state
        S2 = 2'b10  // Flipping bits state
    } state_t;

    // State registers
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
            S0: next_state = S1; // Move to subtract one state
            S1: next_state = S2; // Move to flipping bits state
            S2: next_state = S2; // Stay in the flipping bits state
            default: next_state = S0; // Default state
        endcase
    end

    // Combinational logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            case (state)
                S0: z <= 1'b0; // No output during initialization
                S1: z <= (x == 1'b1) ? 1'b0 : 1'b1; // Subtract one, if x = '1' then set z = '0', else '1'
                S2: z <= ~x; // Flip input bit
            endcase
        end
    end

endmodule
