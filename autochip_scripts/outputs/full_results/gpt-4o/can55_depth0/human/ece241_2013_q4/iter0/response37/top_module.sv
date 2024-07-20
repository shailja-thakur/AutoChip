module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State declaration
    typedef enum {LOW, MID_LOW, MID_HIGH, HIGH} state_t;
    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end

    // Combinational logic for next state logic
    always @(*) begin
        case(state)
            LOW: begin
                if (s[1] && ~s[2] && ~s[3])
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            MID_LOW: begin
                if (s[2] && ~s[3])
                    next_state = MID_HIGH;
                else if (~s[1])
                    next_state = LOW;
                else
                    next_state = MID_LOW;
            end
            MID_HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (~s[2])
                    next_state = MID_LOW;
                else
                    next_state = MID_HIGH;
            end
            HIGH: begin
                if (~s[3])
                    next_state = MID_HIGH;
                else
                    next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default values
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;

        case(state)
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
            end
            MID_LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 0;
                dfr = (next_state == MID_HIGH) ? 1 : 0;
            end
            MID_HIGH: begin
                fr1 = 1;
                fr2 = 0;
                fr3 = 0;
                dfr = (next_state == HIGH) ? 1 : 0;
            end
            HIGH: begin
                fr1 = 0;
                fr2 = 0;
                fr3 = 0;
            end
        endcase
    end
endmodule
