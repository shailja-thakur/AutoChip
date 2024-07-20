module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum logic [3:0] {
        A, B, S0, S1, S10, G1, G2, P0, P1
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and outputs
    always_comb begin
        f = 0;
        g = 0;
        next_state = current_state; // Default to stay in the current state

        case (current_state)
            A: next_state = B;
            B: begin
                next_state = S0;
                f = 1;
            end
            S0: if (x) next_state = S1;
            S1: if (!x) next_state = S10;
            S10: next_state = x ? G1 : S0;
            G1: begin
                next_state = y ? P1 : G2;
                g = 1;
            end
            G2: begin
                next_state = y ? P1 : P0;
                g = 1;
            end
            P0: next_state = P0;
            P1: begin
                next_state = P1;
                g = 1;
            end
            default: next_state = A; // Default state if something goes wrong
        endcase
    end

endmodule
