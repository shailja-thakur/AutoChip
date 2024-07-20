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
        LOW,       // No sensors asserted
        BETWEEN_S1_S2, // Only s[1] asserted
        BETWEEN_S2_S3, // s[1] and s[2] asserted
        ABOVE_S3   // s[1], s[2], and s[3] asserted
    } state_t;
    
    reg [2:0] state, next_state; // Define current and next state variables

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default output values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        // Determine the next state and outputs based on the current state and sensors
        case(state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
                if (s[3])     next_state = ABOVE_S3;
                else if (s[2]) next_state = BETWEEN_S2_S3;
                else if (s[1]) next_state = BETWEEN_S1_S2;
                else          next_state = LOW;
            end
            BETWEEN_S1_S2: begin
                fr1 = 1;
                fr2 = 1;
                if (s[3])     next_state = ABOVE_S3;
                else if (s[2]) next_state = BETWEEN_S2_S3;
                else if (!s[1]) next_state = LOW;
                else          next_state = BETWEEN_S1_S2;
            end
            BETWEEN_S2_S3: begin
                fr1 = 1;
                if (s[3]) {
                    next_state = ABOVE_S3;
                    dfr = 1;
                }
                else if (!s[2]) next_state = BETWEEN_S1_S2;
                else           next_state = BETWEEN_S2_S3;
            end
            ABOVE_S3: begin
                if (!s[3]){
                    next_state = BETWEEN_S2_S3;
                    dfr = 1;
                }
                else          next_state = ABOVE_S3;
            end
            default: next_state = LOW;
        endcase
    end
endmodule
