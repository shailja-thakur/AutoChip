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
        LOW = 2'b00,          // Below s1
        BETWEEN_S1_S2 = 2'b01,  // Between s1 and s2
        BETWEEN_S2_S3 = 2'b10,  // Between s2 and s3
        ABOVE_S3 = 2'b11       // Above s3
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s[3]) next_state = ABOVE_S3;
                else if (s[2]) next_state = BETWEEN_S2_S3;
                else if (s[1]) next_state = BETWEEN_S1_S2;
                else next_state = LOW;
            end
            BETWEEN_S1_S2: begin
                if (s[3]) next_state = ABOVE_S3;
                else if (s[2]) next_state = BETWEEN_S2_S3;
                else if (~s[1]) next_state = LOW;
                else next_state = BETWEEN_S1_S2;
            end
            BETWEEN_S2_S3: begin
                if (s[3]) next_state = ABOVE_S3;
                else if (~s[2]) next_state = BETWEEN_S1_S2;
                else next_state = BETWEEN_S2_S3;
            end
            ABOVE_S3: begin
                if (~s[3]) next_state = BETWEEN_S2_S3;
                else next_state = ABOVE_S3;
            end
            default: next_state = LOW;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;
        case (state)
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
            end
            BETWEEN_S1_S2: begin
                fr1 = 1;
                fr2 = 1;
                if (next_state == LOW) dfr = 1;
            end
            BETWEEN_S2_S3: begin
                fr1 = 1;
                if (next_state == BETWEEN_S1_S2) dfr = 1;
            end
            ABOVE_S3: begin
                // No flow rate
            end
        endcase
    end

endmodule
