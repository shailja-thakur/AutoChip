module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        BELOW_S1   = 2'b00,
        BETWEEN_S12 = 2'b01,
        BETWEEN_S23 = 2'b10,
        ABOVE_S3   = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BELOW_S1;
        end else begin
            state <= next_state;
        end
    end
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            case (state)
                ABOVE_S3: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                
                BETWEEN_S23: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= (next_state == BETWEEN_S12 || next_state == BELOW_S1) ? 1 : 0;
                end
                
                BETWEEN_S12: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= (next_state == BELOW_S1) ? 1 : 0;
                end
                
                BELOW_S1: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                
                default: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            endcase
        end
    end
    
    // Next state logic
    always_comb begin
        case (state)
            ABOVE_S3: begin
                if (|s[2:1] == 0) next_state = s[3] ? ABOVE_S3 : BETWEEN_S23;
                else if (~s[2] && s[1]) next_state = BELOW_S1;
                else if (s[2] && ~s[1]) next_state = BETWEEN_S12;
                else next_state = s[3] ? ABOVE_S3 : BETWEEN_S23;
            end
            
            BETWEEN_S23: begin
                if (|s == 0) next_state = BELOW_S1;
                else if (s[3]) next_state = ABOVE_S3;
                else if (s[2] && ~s[1]) next_state = BETWEEN_S12;
                else next_state = s[1] ? BELOW_S1 : BETWEEN_S23;
            end
            
            BETWEEN_S12: begin
                if (|s == 0) next_state = BELOW_S1;
                else if (s[3]) next_state = ABOVE_S3;
                else if (s[2] && ~s[1]) next_state = BETWEEN_S23;
                else next_state = s[1] ? BELOW_S1 : BETWEEN_S12;
            end
            
            BELOW_S1: begin
                if (s[3]) next_state = ABOVE_S3;
                else if (s[2]) next_state = BETWEEN_S23;
                else if (s[1]) next_state = BETWEEN_S12;
                else next_state = BELOW_S1;
            end
            
            default: next_state = BELOW_S1;
        endcase
    end
    
endmodule
