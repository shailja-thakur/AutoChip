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
        LOW = 2'b00,           // Below s[1]
        BETWEEN_S2_S1 = 2'b01, // Between s[2] and s[1]
        BETWEEN_S3_S2 = 2'b10, // Between s[3] and s[2]
        ABOVE_S3 = 2'b11       // Above s[3]
    } state_t;

    state_t state, next_state;
    state_t prev_state;

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default case
        next_state = state;
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;

        case (state)
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE_S3;
                else if (s[1] && s[2])
                    next_state = BETWEEN_S3_S2;
                else if (s[1])
                    next_state = BETWEEN_S2_S1;
            end

            BETWEEN_S2_S1: begin
                fr1 = 1;
                fr2 = 1;
                if (prev_state == LOW) 
                    dfr = 1;
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE_S3;
                else if (s[1] && s[2])
                    next_state = BETWEEN_S3_S2;
                else if (~s[1] && ~s[2] && ~s[3])
                    next_state = LOW;
            end

            BETWEEN_S3_S2: begin
                fr1 = 1;
                if (prev_state == BETWEEN_S2_S1)
                    dfr = 1;
                if (s[1] && s[2] && s[3])
                    next_state = ABOVE_S3;
                else if (~s[1] && ~s[2] && ~s[3])
                    next_state = LOW;
                else if (s[1] && ~s[2])
                    next_state = BETWEEN_S2_S1;
            end

            ABOVE_S3: begin
                if (~s[1] && ~s[2] && ~s[3])
                    next_state = LOW;
                else if (s[1] && s[2] && ~s[3])
                    next_state = BETWEEN_S3_S2;
                else if (s[1] && ~s[2])
                    next_state = BETWEEN_S2_S1;
            end

            default: begin
                // shouldn't happen
                next_state = LOW;
            end
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_state <= LOW;
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
        end else begin
            prev_state <= state;
            state <= next_state;
        end
    end
endmodule
