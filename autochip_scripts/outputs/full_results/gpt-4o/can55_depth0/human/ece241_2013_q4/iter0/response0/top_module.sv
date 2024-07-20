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
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                if (s[1]) next_state = MID_LOW;
            end

            MID_LOW: begin
                fr1 = 1;
                fr2 = 1;
                if (s[2]) begin
                    next_state = MID_HIGH;
                    dfr = 1;
                end else if (!s[1]) next_state = LOW;
            end

            MID_HIGH: begin
                fr1 = 1;
                if (s[3]) begin
                    next_state = HIGH;
                end else if (!s[2]) next_state = MID_LOW;
            end

            HIGH: begin
                if (!s[3]) next_state = MID_HIGH;
            end

            default: next_state = LOW;
        endcase
    end

endmodule
