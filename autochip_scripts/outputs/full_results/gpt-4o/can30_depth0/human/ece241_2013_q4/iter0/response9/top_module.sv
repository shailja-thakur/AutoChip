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
    typedef enum reg [1:0] {
        LOW = 2'b00,         // No sensors asserted
        BETWEEN_S1_S2 = 2'b01, // s[1] asserted
        BETWEEN_S2_S3 = 2'b10, // s[1], s[2] asserted
        ABOVE_S3 = 2'b11      // s[1], s[2], s[3] asserted
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= LOW;
        else 
            state <= next_state;
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        next_state = state;

        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
                if (s[3]) 
                    next_state = ABOVE_S3;
                else if (s[2])
                    next_state = BETWEEN_S2_S3;
                else if (s[1])
                    next_state = BETWEEN_S1_S2;
            end

            BETWEEN_S1_S2: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[3]) 
                    next_state = ABOVE_S3;
                else if (s[2])
                    next_state = BETWEEN_S2_S3;
                else if (!s[1])
                    next_state = LOW;
            end

            BETWEEN_S2_S3: begin
                fr1 = 1'b1;
                if (s[3])
                    next_state = ABOVE_S3;
                else if (!s[2])
                    next_state = (s[1] ? BETWEEN_S1_S2 : LOW);
            end

            ABOVE_S3: begin
                if (!s[3])
                    next_state = (s[2] ? BETWEEN_S2_S3 : (s[1] ? BETWEEN_S1_S2 : LOW));
            end
        endcase

        // Set dfr based on the level of transition
        if (next_state == ABOVE_S3 && state != ABOVE_S3) dfr = 1'b1;
        else if (next_state == BETWEEN_S2_S3 && state == BETWEEN_S1_S2) dfr = 1'b1;
        else if (next_state == BETWEEN_S1_S2 && state == LOW) dfr = 1'b1;
    end
endmodule
