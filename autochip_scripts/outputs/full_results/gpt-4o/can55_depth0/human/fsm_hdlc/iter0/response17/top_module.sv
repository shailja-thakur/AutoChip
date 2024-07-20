module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);
    
    typedef enum reg [2:0] {
        S0,     // No ones seen, or reset state
        S1,     // One 1
        S2,     // Two 1s
        S3,     // Three 1s
        S4,     // Four 1s
        S5,     // Five 1s
        S6,     // Six 1s
        ERROR   // Seven or more 1s
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
        
        // State transitions and output logic
        case (state)
            S0: begin
                if (in)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (in)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = S0;
            end
            S5: begin
                if (in)
                    next_state = S6;
                else
                    next_state = S0;
            end
            S6: begin
                if (in) begin
                    next_state = ERROR;
                    err = 1'b1; // Error: seven or more consecutive 1s
                end else
                    next_state = S0;
                    disc = 1'b1; // 0111110 sequence
            end
            ERROR: begin
                if (in)
                    next_state = ERROR;
                else
                    next_state = S0;
            end
        endcase
        
        // Special condition for flag: 01111110
        if (state == S5 && in == 1'b1 && next_state == S6)
            flag = 1'b1;
    end
endmodule
