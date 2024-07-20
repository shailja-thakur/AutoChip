module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);
    
    // Define states
    typedef enum logic [2:0] {
        S0, // initial state (previous input is 0)
        S1, // seen 0
        S2, // 1 after 0
        S3, // 11 after 0
        S4, // 111 after 0
        S5, // 1111 after 0
        S6, // 11111 after 0
        S7, // 0111111 (6 consecutive 1s)
        S8, // 01111110 (flag)
        S9  // more than 6 consecutive 1s (error)
    } state_t;
    
    state_t state, next_state;
    
    // Sequential logic: state transitions
    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    // Combinatorial logic
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        // Next state logic
        case (state)
            S0: next_state = in ? S2 : S1;
            S1: next_state = in ? S2 : S1;
            S2: next_state = in ? S3 : S1;
            S3: next_state = in ? S4 : S1;
            S4: next_state = in ? S5 : S1;
            S5: next_state = in ? S6 : S1;
            S6: begin
                if (in) 
                    next_state = S7;
                else 
                    next_state = S1;
            end
            S7: begin
                if (in) 
                    next_state = S9;
                else 
                    next_state = S8;
            end
            S8: begin
                flag = 1'b1;
                next_state = in ? S2 : S1;
            end
            S9: begin
                if (in) 
                    next_state = S9;
                else 
                    next_state = S1;
                err = 1'b1;
            end
            default: next_state = S0;
        endcase
        
        // Output logic
        case (state)
            S6: if (~in) disc = 1'b1;
            S8: flag = 1'b1;
            S9: err = 1'b1;
            default: begin
                disc = 1'b0;
                flag = 1'b0;
                err = 1'b0;
            end
        endcase
    end
    
endmodule
