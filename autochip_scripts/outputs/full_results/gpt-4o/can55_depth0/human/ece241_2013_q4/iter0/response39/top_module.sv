module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum reg [1:0] {
        LOW = 2'b00,
        BETWEEN_LOW_MID = 2'b01,
        BETWEEN_MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end

    always @(*) begin
        // Default values
        next_state = state;
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                if (s[1])
                    next_state = BETWEEN_LOW_MID;
            end
            BETWEEN_LOW_MID: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (!s[1])
                    next_state = LOW;
            end
            BETWEEN_MID_HIGH: begin
                fr1 = 1'b1;
                if (s[3])
                    next_state = HIGH;
                else if (!s[2])
                    next_state = BETWEEN_LOW_MID;
            end
            HIGH: begin
                if (!s[3])
                    next_state = BETWEEN_MID_HIGH;
            end
        endcase

        // Determine dfr based on state change
        if (next_state < state)
            dfr = 1'b1;
    end

endmodule
