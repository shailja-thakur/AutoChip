module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
    
    // Define states
    typedef enum logic [3:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_t;
    
    // Declare state and next_state variables
    state_t state, next_state;
    
    // Declare combinatorial logic to determine next_state based on current state and inputs
    always_comb begin
        case(state)
            A: if (s) next_state = B; else next_state = A;
            B, C: if (w) next_state = S11; else next_state = S10;
            S10: if (w) next_state = S21; else next_state = S20;
            S11: if (w) next_state = S22; else next_state = S21;
            S20: next_state = B;
            S21: if (w) next_state = C; else next_state = B;
            S22: if (w) next_state = B; else next_state = C;
            default: next_state = A;
        endcase
    end
    
    // Declare sequential logic to update state on clock edge
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output
    always_comb begin
        case(state)
            A: z = 0;
            default: z = 1;
        endcase
    end

endmodule
