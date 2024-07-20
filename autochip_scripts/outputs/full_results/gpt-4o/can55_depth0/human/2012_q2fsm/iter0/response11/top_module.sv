module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State declarations
    typedef enum logic [2:0] {
        A = 3'b000, 
        B = 3'b001, 
        C = 3'b010, 
        D = 3'b011, 
        E = 3'b100, 
        F = 3'b101
    } state_t;
    
    state_t current_state, next_state;
    
    // State flip-flops with synchronous reset
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // State table (next state logic)
    always_comb begin
        case (current_state)
            A: begin
                if (w)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (w)
                    next_state = C;
                else
                    next_state = D;
            end
            C: begin
                if (w)
                    next_state = E;
                else
                    next_state = D;
            end
            D: begin
                if (w)
                    next_state = F;
                else
                    next_state = A;
            end
            E: begin
                if (w)
                    next_state = E;
                else
                    next_state = D;
            end
            F: begin
                if (w)
                    next_state = C;
                else
                    next_state = D;
            end
            default: next_state = A; // default to a safe state
        endcase
    end
    
    // Output logic
    always_comb begin
        case (current_state)
            A, B, C, D: z = 1'b0;
            E, F: z = 1'b1;
            default: z = 1'b0; // default to a safe output
        endcase
    end

endmodule
