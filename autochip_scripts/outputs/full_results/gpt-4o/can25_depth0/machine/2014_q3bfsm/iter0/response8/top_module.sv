module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101,
        G = 3'b110,
        H = 3'b111
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // Initialize state to A
        else
            state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        next_state = state;  // Default state is to stay in the same state
        z = 1'b0;            // Default output is 0

        case(state)
            A: begin
                if (x)
                    next_state = B;
                // else remains A
            end
            B: begin
                if (x)
                    next_state = E;
                // else remains B
            end
            C: begin
                if (x)
                    next_state = B;
                // else remains C
            end
            D: begin
                if (x)
                    next_state = C;
                else
                    next_state = B;
                z = 1'b1;  // Output is high in state D
            end
            E: begin
                if (x)
                    next_state = E;
                else
                    next_state = D;
                z = 1'b1;  // Output is high in state E
            end
            // Define default case to handle unknown states
            default: begin
                next_state = A;
            end
        endcase
    end
endmodule
