module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define the states
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    // State register
    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;                      // Initialize to state A on reset
        end else begin
            state <= next_state;             // Transition to next state on clock edge
        end
    end

    // Combinational logic for next state
    always_comb begin
        case (state)
            A: begin
                if (j) 
                    next_state = B;           // Input j determines the next state from A
                else 
                    next_state = A;
            end
            B: begin
                if (k) 
                    next_state = A;           // Input k determines the next state from B
                else 
                    next_state = B;
            end
            default: next_state = A;          // Default state
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 1'b0;                     // Output is low when in state A
        end else begin
            out <= (state == B);             // Output is high when in state B
        end
    end
endmodule
