module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01  // Flipping bits state, handle 1's complement and add1
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
            S0: next_state = S1; // Move from initial to flip state
            S1: next_state = S1; // Stay in the flip state
            default: next_state = S0; // Default state
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            case (state)
                S0: z <= 1'b0; // Reset output in initial state
                S1: begin
                    z <= ~x; // Perform 1's complement
                end
            endcase
        end
    end
endmodule
