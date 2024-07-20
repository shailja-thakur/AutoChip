module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum logic [2:0] {
        S0 = 3'b000, // Initial state
        S1 = 3'b001, // Flipping bits state
        S2 = 3'b010  // Adding 1 stage state
    } state_t;

    // State variables
    state_t state, next_state;

    // Flip-flop to track if the addition is done
    reg flip;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            flip <= 1'b0;
            z <= 1'b0;
        end 
        else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S0: next_state = S1; // Move from initial to flip state
            S1: next_state = S2; // Move from flip to add state
            S2: next_state = S1; // Stay in the flip state
            default: next_state = S0; // Default state
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            flip <= 1'b0;
        end 
        else begin
            case (state)
                S0: begin
                    z <= 1'b0;
                end
                S1: begin
                    z <= (flip) ? ~x : z; // Flip bits
                    flip <= 1'b1; // Set flip to true
                end
                S2: begin
                    if (flip) begin
                        z <= z + 1'b1; // Add 1 to flipped bits
                        flip <= 1'b0; // Reset flip
                    end
                end
            endcase
        end
    end

endmodule
