module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding
    typedef enum logic [1:0] {
        LOW,  // Below s[1]
        MID1, // Between s[1] and s[2]
        MID2, // Between s[2] and s[3]
        HIGH  // Above s[3]
    } state_t;

    state_t state, next_state;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= LOW;
        else 
            state <= next_state;
    end

    always_comb begin
        // Default values (no flow)
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        
        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                if (s[1])
                    next_state = MID1;
                else
                    next_state = LOW;
            end
            
            MID1: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[2])
                    next_state = MID2;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = MID1;
            end
            
            MID2: begin
                fr1 = 1'b1;
                if (s[3])
                    next_state = HIGH;
                else if (!s[2])
                    next_state = MID1;
                else
                    next_state = MID2;
            end
            
            HIGH: begin
                if (!s[3])
                    next_state = MID2;
                else
                    next_state = HIGH;
            end
            
            default: 
                next_state = LOW;

        endcase
        
        // Handling Supplemental Flow Valve based on state transitions
        if ((state == LOW && next_state == MID1) || (state == MID1 && next_state == MID2) || 
            (state == MID2 && next_state == HIGH)) 
        begin
            dfr = 1'b1;
        end
    end
    
endmodule
