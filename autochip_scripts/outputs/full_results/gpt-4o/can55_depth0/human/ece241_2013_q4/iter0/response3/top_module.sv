module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum reg [1:0] {
        BELOW_S1,
        BETWEEN_S1_S2,
        BETWEEN_S2_S3,
        ABOVE_S3
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BELOW_S1;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case (state)
            BELOW_S1: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                if (s[1])
                    next_state = BETWEEN_S1_S2;
                else
                    next_state = BELOW_S1;
            end
            
            BETWEEN_S1_S2: begin
                fr1 = 1;
                fr2 = 1;
                if (s[2])
                    next_state = BETWEEN_S2_S3;
                else if (!s[1])
                    next_state = BELOW_S1;
                else
                    next_state = BETWEEN_S1_S2;
            end
            
            BETWEEN_S2_S3: begin
                fr1 = 1;
                if (s[3])
                    next_state = ABOVE_S3;
                else if (!s[2])
                    next_state = BETWEEN_S1_S2;
                else
                    next_state = BETWEEN_S2_S3;
            end
            
            ABOVE_S3: begin
                if (!s[3])
                    next_state = BETWEEN_S2_S3;
                else
                    next_state = ABOVE_S3;
            end
            
            default: begin
                next_state = BELOW_S1;
            end
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dfr <= 0;
        end else begin
            if (next_state == BETWEEN_S2_S3 && state == BETWEEN_S1_S2)
                dfr <= 1;
            else if (next_state == ABOVE_S3)
                dfr <= 0;
            else if (next_state == BETWEEN_S1_S2 && state == BELOW_S1)
                dfr <= 1;
            else
                dfr <= 0;
        end
    end
    
endmodule
