module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State definitions
    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;

    // Sequential logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end

    // Combinational logic
    always_comb begin
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        next_state = state;

        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                if (s[1] && s[2] && s[3])
                    next_state = HIGH;
                else if (s[1] && s[2])
                    next_state = MID_HIGH;
                else if (s[1])
                    next_state = MID_LOW;
            end
            MID_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[1] && s[2] && s[3])
                    next_state = HIGH;
                else if (s[1] && s[2])
                    next_state = MID_HIGH;
                else if (!s[1])
                    next_state = LOW;
            end
            MID_HIGH: begin
                fr1 = 1'b1;
                if (s[1] && s[2] && s[3])
                    next_state = HIGH;
                else if (!s[2])
                    next_state = MID_LOW;
            end
            HIGH: begin
                if (!s[3])
                    next_state = MID_HIGH;
            end
        endcase
        
        // Determine dfr based on transition
        if ((state == MID_LOW && next_state == MID_HIGH) || (state == MID_HIGH && next_state == HIGH))
            dfr = 1'b1;
    end
endmodule
