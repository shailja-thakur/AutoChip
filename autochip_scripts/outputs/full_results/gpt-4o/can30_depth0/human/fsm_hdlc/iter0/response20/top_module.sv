module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    // State definitions
    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // Seen 0
        S2, // Seen 01
        S3, // Seen 011
        S4, // Seen 0111
        S5, // Seen 01111
        S6, // Seen 011111
        S7, // Seen 0111111 (potential flag or disc)
        S8  // Error state
    } state_t;
    
    state_t state, next_state;
    
    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
    
        case (state)
            S0: begin
                if (in) next_state = S1;
                else next_state = S0;
            end
            
            S1: begin
                if (in) next_state = S2;
                else next_state = S0;
            end
            
            S2: begin
                if (in) next_state = S3;
                else next_state = S0;
            end
            
            S3: begin
                if (in) next_state = S4;
                else next_state = S0;
            end
            
            S4: begin
                if (in) next_state = S5;
                else next_state = S0;
            end
            
            S5: begin
                if (in) next_state = S6;
                else next_state = S0;
            end
            
            S6: begin
                if (in) next_state = S7;
                else next_state = S0;
            end
            
            S7: begin
                if (in) next_state = S8; // 01111111
                else begin
                    next_state = S0;
                    flag = 1'b1; // 01111110 detected
                end
            end
            
            S8: begin
                if (in) next_state = S8; // Remain in error state
                else begin
                    next_state = S0;
                    err = 1'b1;
                end
            end
            
            default: next_state = S0; 
        endcase
        
        // Handle the need to discard in S6
        if (state == S6 && in == 1'b0) disc = 1'b1; // 0111110 detected
    end

endmodule
