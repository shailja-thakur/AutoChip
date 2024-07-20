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
        BETWEEN1_AND_2 = 2'b01,
        BETWEEN2_AND_3 = 2'b10,
        ABOVE3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg previous_level_low; // Keeps track of if the previous level was lower than the current level
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            previous_level_low <= 1;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            LOW: begin
                if (s[1])
                    next_state = BETWEEN1_AND_2;
                else
                    next_state = LOW;
            end
            BETWEEN1_AND_2: begin
                if (s[2])
                    next_state = BETWEEN2_AND_3;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = BETWEEN1_AND_2;
            end
            BETWEEN2_AND_3: begin
                if (s[3])
                    next_state = ABOVE3;
                else if (!s[2])
                    next_state = BETWEEN1_AND_2;
                else
                    next_state = BETWEEN2_AND_3;
            end
            ABOVE3: begin
                if (!s[3])
                    next_state = BETWEEN2_AND_3;
                else
                    next_state = ABOVE3;
            end
            default: next_state = LOW;
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
        end else begin
            fr1 <= 0;
            fr2 <= 0;
            fr3 <= 0;
            dfr <= 0;
            case (next_state)
                ABOVE3: begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                end
                BETWEEN2_AND_3: begin
                    fr1 <= 1;
                    if (!previous_level_low) dfr <= 1;
                end
                BETWEEN1_AND_2: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    if (!previous_level_low) dfr <= 1;
                end
                LOW: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                end
            endcase
            
            // Update previous level status
            previous_level_low <= (current_state < next_state);
        end
    end
endmodule
