module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding for FSM
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    // FSM state registers
    reg [1:0] state, next_state;
    reg previous_level_was_low;

    // State transition logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s[1] == 1'b1)
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            MID_LOW: begin
                if (s[1] == 1'b0)
                    next_state = LOW;
                else if (s[2] == 1'b1)
                    next_state = MID_HIGH;
                else
                    next_state = MID_LOW;
            end
            MID_HIGH: begin
                if (s[2] == 1'b0)
                    next_state = MID_LOW;
                else if (s[3] == 1'b1)
                    next_state = HIGH;
                else
                    next_state = MID_HIGH;
            end
            HIGH: begin
                if (s[3] == 1'b0)
                    next_state = MID_HIGH;
                else
                    next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // Output logic based on state
    always @(*) begin
        // Default all flow rates to 0
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        
        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                previous_level_was_low = 1'b1;
            end
            MID_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (!previous_level_was_low) begin
                    dfr = 1'b1;
                end
            end
            MID_HIGH: begin
                fr1 = 1'b1;
                if (!previous_level_was_low) begin
                    dfr = 1'b1;
                end
            end
            HIGH: begin
                // No outputs asserted
            end
        endcase
    end

    // State register update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            previous_level_was_low <= 1'b1;
        end else begin
            state <= next_state;
            if (state != next_state) begin
                previous_level_was_low <= (next_state == LOW);
            end
        end
    end
endmodule
