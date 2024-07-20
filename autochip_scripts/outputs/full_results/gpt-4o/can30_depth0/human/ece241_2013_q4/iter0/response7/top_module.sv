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
        LOW = 2'b00,
        BETWEEN_1_2 = 2'b01,
        BETWEEN_2_3 = 2'b10,
        ABOVE_3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Previous state to determine the direction of change
    state_t prev_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset state to low water level
            state <= LOW;
            prev_state <= LOW;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            prev_state <= state;
            state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        // Defaults
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
                if (s[1])
                    next_state = BETWEEN_1_2;
                else
                    next_state = LOW;
            end

            BETWEEN_1_2: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (prev_state == LOW)
                    dfr = 1'b1; // Supplemental flow is increased from low level

                if (s[2])
                    next_state = BETWEEN_2_3;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = BETWEEN_1_2;
            end

            BETWEEN_2_3: begin
                fr1 = 1'b1;
                if (prev_state == BETWEEN_1_2)
                    dfr = 1'b1; // Supplemental flow is increased from lower level

                if (s[3])
                    next_state = ABOVE_3;
                else if (!s[2])
                    next_state = BETWEEN_1_2;
                else
                    next_state = BETWEEN_2_3;
            end

            ABOVE_3: begin
                // No flow required
                if (!s[3])
                    next_state = BETWEEN_2_3;
                else
                    next_state = ABOVE_3;
            end

            default: begin
                next_state = LOW;
            end
        endcase
    end
endmodule
