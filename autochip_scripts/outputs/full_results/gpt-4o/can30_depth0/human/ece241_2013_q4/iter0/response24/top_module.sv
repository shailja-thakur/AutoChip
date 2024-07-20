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

    // State transition logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s[3]) next_state = HIGH;
                else if (s[2]) next_state = MID_HIGH;
                else if (s[1]) next_state = MID_LOW;
                else next_state = LOW;
            end
            MID_LOW: begin
                if (s[3]) next_state = HIGH;
                else if (s[2]) next_state = MID_HIGH;
                else if (!s[1]) next_state = LOW;
                else next_state = MID_LOW;
            end
            MID_HIGH: begin
                if (s[3]) next_state = HIGH;
                else if (!s[2] && s[1]) next_state = MID_LOW;
                else if (!s[2] && !s[1]) next_state = LOW;
                else next_state = MID_HIGH;
            end
            HIGH: begin
                if (!s[3] && s[2]) next_state = MID_HIGH;
                else if (!s[3] && s[1]) next_state = MID_LOW;
                else if (!s[3]) next_state = LOW;
                else next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end
            MID_LOW: begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end
            MID_HIGH: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = 0; // Supplemental flow valve is closed
            end
            HIGH: begin
                // All outputs remain 0
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
        endcase
    end
endmodule
