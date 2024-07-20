module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State declaration
    typedef enum logic [1:0] {
        LOW_LEVEL,
        MID_LEVEL,
        HIGH_LEVEL,
        ABOVE_HIGH
    } water_level_t;
    
    water_level_t state, next_state;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW_LEVEL;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic and Output Logic
    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case (state)
            LOW_LEVEL: begin
                // Below s[1]
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE_HIGH;
                else if (s[1] && s[2])
                    next_state = HIGH_LEVEL;
                else if (s[1])
                    next_state = MID_LEVEL;
                else
                    next_state = LOW_LEVEL;
            end
            
            MID_LEVEL: begin
                // Between s[2] and s[1]
                fr2 = 1;
                fr1 = 1;
                if (s[3])
                    next_state = ABOVE_HIGH;
                else if (s[2])
                    next_state = HIGH_LEVEL;
                else if (!s[1])
                    next_state = LOW_LEVEL;
                else
                    next_state = MID_LEVEL;
            end
            
            HIGH_LEVEL: begin
                // Between s[3] and s[2]
                fr1 = 1;
                if (!s[1] && !s[2])
                    next_state = LOW_LEVEL;
                else if (s[3])
                    next_state = ABOVE_HIGH;
                else if (!s[2])
                    next_state = MID_LEVEL;
                else
                    next_state = HIGH_LEVEL;
            end
            
            ABOVE_HIGH: begin
                // Above s[3]
                if (!s[1] && !s[2] && !s[3])
                    next_state = LOW_LEVEL;
                else if (!s[3])
                    next_state = HIGH_LEVEL;
                else
                    next_state = ABOVE_HIGH;
            end
        endcase
        
        // Differential Flow Rate control
        if (state < next_state) begin
            dfr = 1;
        end
    end

endmodule
