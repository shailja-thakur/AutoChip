module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    
    // Define state encoding
    typedef enum reg [1:0] {
        BELOW_S1 = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;

    // Internal state variables
    reg [1:0] current_state, next_state;
    reg previous_level;  // 0: lower, 1: higher

    // State transition logic
    always @(*) begin
        case (current_state)
            BELOW_S1: begin
                if (s[1]) next_state = BETWEEN_S1_S2;
                else next_state = BELOW_S1;
            end
            
            BETWEEN_S1_S2: begin
                if (s[2]) next_state = BETWEEN_S2_S3;
                else if (!s[1]) next_state = BELOW_S1;
                else next_state = BETWEEN_S1_S2;
            end

            BETWEEN_S2_S3: begin
                if (s[3]) next_state = ABOVE_S3;
                else if (!s[2]) next_state = BETWEEN_S1_S2;
                else next_state = BETWEEN_S2_S3;
            end

            ABOVE_S3: begin
                if (!s[3]) next_state = BETWEEN_S2_S3;
                else next_state = ABOVE_S3;
            end
            
            default: next_state = BELOW_S1;
        endcase
    end

    // State flip-flops and reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BELOW_S1;
            previous_level <= 0;
        end else begin
            current_state <= next_state;
            
            // Update the previous level
            if (next_state == ABOVE_S3 && current_state != ABOVE_S3) previous_level <= 1; // higher
            else if (next_state == BELOW_S1 && current_state != BELOW_S1) previous_level <= 0; // lower
        end
    end

    // Output logic
    always @(*) begin
        // Default outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case (current_state)
            BELOW_S1: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
            end

            BETWEEN_S1_S2: begin
                fr2 = 1;
                fr1 = 1;
                if (previous_level == 1'b0) // previous level was lower
                    dfr = 1;
            end

            BETWEEN_S2_S3: begin
                fr1 = 1;
                if (previous_level == 1'b0) // previous level was lower
                    dfr = 1;
            end

            ABOVE_S3: begin
                // No flow rate required, all outputs remain 0
            end
        endcase
    end

endmodule
