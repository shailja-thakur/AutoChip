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
        BELOW_S1       = 2'b00,
        BETWEEN_S1_S2  = 2'b01,
        BETWEEN_S2_S3  = 2'b10,
        ABOVE_S3       = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg previous_level_lower;

    // State transition logic
    always @(*) begin
        case (current_state)
            BELOW_S1:       next_state = (s[1]) ? BETWEEN_S1_S2  : BELOW_S1;
            BETWEEN_S1_S2:  next_state = (s[2]) ? BETWEEN_S2_S3  : (s[1] ? BETWEEN_S1_S2 : BELOW_S1);
            BETWEEN_S2_S3:  next_state = (s[3]) ? ABOVE_S3       : (s[2] ? BETWEEN_S2_S3 : BETWEEN_S1_S2);
            ABOVE_S3:       next_state = (s[3]) ? ABOVE_S3       : BETWEEN_S2_S3;
            default:        next_state = BELOW_S1;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            BELOW_S1: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
            BETWEEN_S1_S2: begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
                dfr = previous_level_lower ? 1 : 0;
            end
            BETWEEN_S2_S3: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = previous_level_lower ? 1 : 0;
            end
            ABOVE_S3: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
            default: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
        endcase
    end

    // Previous level comparison for dfr determination
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            previous_level_lower <= 1'b0;
        end else begin
            if (current_state != next_state) begin
                if (next_state > current_state) begin
                    previous_level_lower <= 1'b1;
                end else begin
                    previous_level_lower <= 1'b0;
                end
            end
        end
    end

    // State registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BELOW_S1;
        end else begin
            current_state <= next_state;
        end
    end

endmodule
