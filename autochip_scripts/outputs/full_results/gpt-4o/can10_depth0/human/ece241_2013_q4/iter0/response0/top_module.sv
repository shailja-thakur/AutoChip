module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // Defining states
    typedef enum reg [1:0] {
        BELOW_S1 = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg previous_level_lower;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BELOW_S1;
            previous_level_lower <= 1'b0;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            BELOW_S1: begin
                if (s[1])
                    next_state = BETWEEN_S1_S2;
                else
                    next_state = BELOW_S1;
            end
            BETWEEN_S1_S2: begin
                if (s[2])
                    next_state = BETWEEN_S2_S3;
                else if (~s[1])
                    next_state = BELOW_S1;
                else
                    next_state = BETWEEN_S1_S2;
            end
            BETWEEN_S2_S3: begin
                if (s[3])
                    next_state = ABOVE_S3;
                else if (~s[2])
                    next_state = BETWEEN_S1_S2;
                else
                    next_state = BETWEEN_S2_S3;
            end
            ABOVE_S3: begin
                if (~s[3])
                    next_state = BETWEEN_S2_S3;
                else
                    next_state = ABOVE_S3;
            end
            default: next_state = BELOW_S1;
        endcase

        // Determine if the previous level was lower
        if (next_state > current_state)
            previous_level_lower = 1'b1;
        else
            previous_level_lower = 1'b0;
    end

    // Output Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end
        else begin
            case (next_state)
                BELOW_S1: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
                BETWEEN_S1_S2: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= previous_level_lower ? 1'b1 : 1'b0;
                end
                BETWEEN_S2_S3: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= previous_level_lower ? 1'b1 : 1'b0;
                end
                ABOVE_S3: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
            endcase
        end
    end

endmodule
