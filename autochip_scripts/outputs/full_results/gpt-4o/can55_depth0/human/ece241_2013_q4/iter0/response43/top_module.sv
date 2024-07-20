module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum reg [2:0] {
        LOW = 3'b000,        // Below s1
        BETWEEN_S1_S2 = 3'b001, // Between s1 and s2
        BETWEEN_S2_S3 = 3'b010, // Between s2 and s3
        ABOVE_S3 = 3'b011 // Above s3
    } state_t;
    
    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            LOW: begin
                if (s[1])
                    next_state = BETWEEN_S1_S2;
                else
                    next_state = LOW;
            end
            
            BETWEEN_S1_S2: begin
                if (s[2])
                    next_state = BETWEEN_S2_S3;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = BETWEEN_S1_S2;
            end
            
            BETWEEN_S2_S3: begin
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
            
            default: next_state = LOW;
        endcase
    end

    always @(*) begin
        {fr3, fr2, fr1, dfr} = 4'b0000; // Default all outputs to zero
        
        case (current_state)
            LOW: {fr3, fr2, fr1, dfr} = 4'b1111;
            BETWEEN_S1_S2: {fr3, fr2, fr1, dfr} = 4'b0111;
            BETWEEN_S2_S3: {fr3, fr2, fr1, dfr} = 4'b0011;
            ABOVE_S3: {fr3, fr2, fr1, dfr} = 4'b0000;
        endcase
    end
endmodule
