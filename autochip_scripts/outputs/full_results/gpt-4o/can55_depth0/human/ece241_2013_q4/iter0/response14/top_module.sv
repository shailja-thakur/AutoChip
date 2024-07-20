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
        LOW = 2'b00,
        BETWEEN_1_2 = 2'b01,
        BETWEEN_2_3 = 2'b10,
        ABOVE_3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg prev_level_below; // Keeps track if the previous level was below the current level
    
    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
            prev_level_below <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case(state)
            LOW:
                if (s[1])
                    next_state = BETWEEN_1_2;
                else
                    next_state = LOW;
                
            BETWEEN_1_2:
                if (s[2])
                    next_state = BETWEEN_2_3;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = BETWEEN_1_2;
                
            BETWEEN_2_3:
                if (s[3])
                    next_state = ABOVE_3;
                else if (!s[2])
                    next_state = BETWEEN_1_2;
                else
                    next_state = BETWEEN_2_3;
                
            ABOVE_3:
                if (!s[3])
                    next_state = BETWEEN_2_3;
                else
                    next_state = ABOVE_3;
                
            default: next_state = LOW;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end
        else begin
            case (state)
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                    prev_level_below <= 1;
                end
                BETWEEN_1_2: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= prev_level_below;
                    prev_level_below <= 0;
                end
                BETWEEN_2_3: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= prev_level_below;
                    prev_level_below <= 0;
                end
                ABOVE_3: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                    prev_level_below <= 0;
                end
                default: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            endcase
        end
    end
endmodule
