module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // States
    typedef enum logic [1:0] {
        LOW = 2'b00,
        BETWEEN_1_2 = 2'b01,
        BETWEEN_2_3 = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;
    reg prev_s1, prev_s2, prev_s3;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            LOW: begin
                if (s[1])
                    next_state = BETWEEN_1_2;
                else
                    next_state = LOW;
            end

            BETWEEN_1_2: begin
                if (s[2])
                    next_state = BETWEEN_2_3;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = BETWEEN_1_2;
            end

            BETWEEN_2_3: begin
                if (s[3])
                    next_state = HIGH;
                else if (!s[2])
                    next_state = BETWEEN_1_2;
                else
                    next_state = BETWEEN_2_3;
            end

            HIGH: begin
                if (!s[3])
                    next_state = BETWEEN_2_3;
                else
                    next_state = HIGH;
            end

            default: next_state = LOW;
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end

    // Output logic (combinational)
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
                dfr = 0;
            end

            BETWEEN_1_2: begin
                fr1 = 1;
                fr2 = 1;
                if (!prev_s1) dfr = 1;
            end

            BETWEEN_2_3: begin
                fr1 = 1;
                if (!prev_s2) dfr = 1;
            end

            HIGH: begin
                // No outputs are asserted in this state
            end
        endcase
    end

    // Register previous sensor states (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            prev_s1 <= 0;
            prev_s2 <= 0;
            prev_s3 <= 0;
        end else begin
            prev_s1 <= s[1];
            prev_s2 <= s[2];
            prev_s3 <= s[3];
        end
    end
endmodule
