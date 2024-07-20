module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
    
    // Define states using enum
    typedef enum logic [3:0] {
        A,
        B,
        S0,
        S1,
        S10,
        G1,
        G2,
        P0,
        P1
    } state_t;
    
    // Declare state and next_state variables
    state_t state, next_state;
    
    // Declare and initialize output signal variables
    logic f_reg = 0;
    logic g_reg = 0;
    
    always_ff @(posedge clk, negedge resetn)
    begin
        if (!resetn)
        begin
            state <= A; // Initial state
        end
        else
        begin
            state <= next_state; // Update state based on next_state
        end
    end
    
    always_comb
    begin
        // Default assignments
        f = 0;
        g = 0;
        
        case (state)
            A:
                if (x)
                    next_state = B;
                else
                    next_state = S0;
            B:
                next_state = S0;
                f_reg = 1; // Set f to 1 when state is B
            S0:
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            S1:
                if (x)
                    next_state = S1;
                else
                    next_state = S10;
            S10:
                if (x)
                    next_state = G1;
                else
                    next_state = S0;
            G1:
                if (y)
                    next_state = P1;
                else
                    next_state = G2;
            G2:
                if (y)
                    next_state = P1;
                else
                    next_state = P0;
            P0:
                next_state = P0;
            P1:
                next_state = P1;
                g_reg = 1; // Set g to 1 when state is G1 or G2 or P1
            default:
                next_state = A;
        endcase
    end
    
    // Assign output signals
    assign f = f_reg;
    assign g = g_reg;
    
endmodule
