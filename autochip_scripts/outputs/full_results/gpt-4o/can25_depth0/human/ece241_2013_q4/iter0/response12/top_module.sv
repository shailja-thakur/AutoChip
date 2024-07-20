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
        IDLE,
        LEVEL1,
        LEVEL2,
        LEVEL3
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= LEVEL1;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            LEVEL1: begin
                if (s[3])
                    next_state = IDLE;
                else if (s[2])
                    next_state = LEVEL3;
                else if (s[1])
                    next_state = LEVEL2;
                else
                    next_state = LEVEL1;
            end
            LEVEL2: begin
                if (s[3])
                    next_state = IDLE;
                else if (s[2])
                    next_state = LEVEL3;
                else if (!s[1])
                    next_state = LEVEL1;
                else
                    next_state = LEVEL2;
            end
            LEVEL3: begin
                if (s[3])
                    next_state = IDLE;
                else if (!s[2])
                    next_state = LEVEL1;
                else
                    next_state = LEVEL3;
            end
            IDLE: begin
                if (!s[3])
                    next_state = LEVEL1;
                else
                    next_state = IDLE;
            end
            default: next_state = LEVEL1;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            fr3 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            case (current_state)
                LEVEL1: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b1;
                    dfr <= 1'b1;
                end
                LEVEL2: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b0;
                    dfr <= 1'b1;
                end
                LEVEL3: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b1;
                end
                IDLE: begin
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end
                default: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b1;
                    dfr <= 1'b1;
                end
            endcase
        end
    end
endmodule
