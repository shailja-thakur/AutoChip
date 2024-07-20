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
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;
	
    // History of previous state
    reg was_lower;

    // State transition logic
    always @(*) begin
        case (state)
            LOW:
                if (s[1])
                    next_state = s[2] ? MID_HIGH : MID_LOW;
                else
                    next_state = LOW;

            MID_LOW:
                if (s[2])
                    next_state = MID_HIGH;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = MID_LOW;

            MID_HIGH:
                if (s[3])
                    next_state = HIGH;
                else if (!s[2])
                    next_state = MID_LOW;
                else
                    next_state = MID_HIGH;

            HIGH:
                if (!s[3])
                    next_state = MID_HIGH;
                else
                    next_state = HIGH;
            
            default: next_state = LOW;
        endcase
    end

    // Output logic
    always @(*) begin
        {fr3, fr2, fr1, dfr} = 4'b0000;
        case(state)
            HIGH:; // No flow valve open
            MID_HIGH: begin
                fr1 = 1;
                if (was_lower) dfr = 1;
            end
            MID_LOW: begin
                fr1 = 1;
                fr2 = 1;
                if (was_lower) dfr = 1;
            end
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                if (!s[1]) dfr = 1;
            end
        endcase
    end

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            was_lower <= 1;
        end else begin
            was_lower <= (state < next_state) ? 1 : 0;
            state <= next_state;
        end
    end

endmodule
