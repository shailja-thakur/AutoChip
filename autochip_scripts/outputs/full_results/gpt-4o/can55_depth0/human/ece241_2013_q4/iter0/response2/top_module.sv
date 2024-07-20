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
        LOW  = 2'b00,
        MID  = 2'b01,
        HIGH = 2'b10,
        FULL = 2'b11
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
                if (s[1]) next_state = MID;
                else next_state = LOW;
            end
            MID: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[2]) next_state = HIGH;
                else if (!s[1]) next_state = LOW;
                else next_state = MID;
            end
            HIGH: begin
                fr1 = 1'b1;
                if (s[3]) next_state = FULL;
                else if (!s[2]) next_state = MID;
                else next_state = HIGH;
            end
            FULL: begin
                if (!s[3]) next_state = HIGH;
                else next_state = FULL;
            end
            default: next_state = LOW;
        endcase

        // Determine if supplemental flow valve should be opened
        if (state != LOW && next_state < state)
            dfr = 1'b1;
    end

endmodule
