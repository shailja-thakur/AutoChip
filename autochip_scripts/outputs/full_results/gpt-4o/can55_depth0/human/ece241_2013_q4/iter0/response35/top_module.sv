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
        LEVEL_LOW    = 2'b00,
        LEVEL_BETWEEN_S1_S2 = 2'b01,
        LEVEL_BETWEEN_S2_S3 = 2'b10,
        LEVEL_HIGH   = 2'b11
    } state_t;

    state_t state, next_state;
    
    // State machine to define the current state
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= LEVEL_LOW;
        else
            state <= next_state;
    end

    // Determine the next state based on the sensor inputs
    always_comb begin
        case (state)
            LEVEL_LOW: begin
                if (s[1])
                    next_state = LEVEL_BETWEEN_S1_S2;
                else
                    next_state = LEVEL_LOW;
            end
            LEVEL_BETWEEN_S1_S2: begin
                if (s[2])
                    next_state = LEVEL_BETWEEN_S2_S3;
                else if (!s[1])
                    next_state = LEVEL_LOW;
                else
                    next_state = LEVEL_BETWEEN_S1_S2;
            end
            LEVEL_BETWEEN_S2_S3: begin
                if (s[3])
                    next_state = LEVEL_HIGH;
                else if (!s[2])
                    next_state = LEVEL_BETWEEN_S1_S2;
                else
                    next_state = LEVEL_BETWEEN_S2_S3;
            end
            LEVEL_HIGH: begin
                if (!s[3])
                    next_state = LEVEL_BETWEEN_S2_S3;
                else
                    next_state = LEVEL_HIGH;
            end
            default: next_state = LEVEL_LOW;
        endcase
    end

    // Output logic based on the current state and the previous state
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            case (next_state)
                LEVEL_LOW: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                LEVEL_BETWEEN_S1_S2: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= (state == LEVEL_LOW); // Open supplemental flow valve if previous level was lower
                end
                LEVEL_BETWEEN_S2_S3: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= (state == LEVEL_BETWEEN_S1_S2); // Open supplemental flow valve if previous level was lower
                end
                LEVEL_HIGH: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                default: ;
            endcase
        end
    end

endmodule
