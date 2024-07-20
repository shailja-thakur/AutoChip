module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    reg [2:0] state;
    reg [2:0] next_state;
    
    // Definitions of states
    parameter STATE_NONE = 3'b000;
    parameter STATE_ABOVE_S3 = 3'b001;
    parameter STATE_BETWEEN_S3_S2 = 3'b010;
    parameter STATE_BETWEEN_S2_S1 = 3'b011;
    parameter STATE_BELOW_S1 = 3'b100;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_NONE;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        fr3 = 0; // Initialize flow rates to default values
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        next_state = state; // Set next state to current state by default
        
        case(state)
            
            STATE_NONE: begin
                // No sensors asserted, all flow rates should be active
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                
                if (s[3]) begin // Check for transition to ABOVE_S3 state
                    next_state = STATE_ABOVE_S3;
                end
            end
            
            STATE_ABOVE_S3: begin
                // Only s[3] sensor asserted, no flow rates should be active
                if (!s[3]) begin // Check for transition to NONE state
                    next_state = STATE_NONE;
                end
            end
            
            STATE_BETWEEN_S3_S2: begin
                // s[1] and s[2] sensors asserted, fr1 flow rate should be active
                fr1 = 1;
                
                if (!s[2]) begin // Check for transition to ABOVE_S3 state
                    next_state = STATE_ABOVE_S3;
                end
                else if (s[3] && s[2]) begin // Check for transition to BETWEEN_S2_S1 state
                    next_state = STATE_BETWEEN_S2_S1;
                end
            end
            
            STATE_BETWEEN_S2_S1: begin
                // Only s[1] sensor asserted, fr1 and fr2 flow rates should be active
                fr1 = 1;
                fr2 = 1;
                
                if (!s[1]) begin // Check for transition to BETWEEN_S3_S2 state
                    next_state = STATE_BETWEEN_S3_S2;
                end
                else if (s[3] && !s[2]) begin // Check for transition to ABOVE_S3 state
                    next_state = STATE_ABOVE_S3;
                end
            end
            
            STATE_BELOW_S1: begin
                // No sensors asserted, fr1, fr2, and fr3 flow rates should be active
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                
                if (s[1]) begin // Check for transition to BETWEEN_S2_S1 state
                    next_state = STATE_BETWEEN_S2_S1;
                end
                else if (s[3] && s[2]) begin // Check for transition to BETWEEN_S3_S2 state
                    next_state = STATE_BETWEEN_S3_S2;
                end
            end
            
            default: next_state = STATE_NONE; // Default state is NONE
            
        endcase
        
        // Opening the supplemental flow valve if previous level was lower than the current level
        if (state == STATE_BELOW_S1 && next_state != STATE_BELOW_S1) begin
            dfr = 1;
        end else begin
            dfr = 0;
        end
        
    end
    
endmodule
