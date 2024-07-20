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
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        FULL = 2'b11
    } state_t;

    state_t state, next_state;
    state_t prev_state, next_prev_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_state <= LOW;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            state <= next_state;
            prev_state <= next_prev_state;
        end
    end

    always_comb begin
        next_state = state;
        next_prev_state = prev_state;
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW: begin
                if (s[1]) begin
                    next_state = MID;
                    next_prev_state = LOW;
                end
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
            end
            MID: begin
                if (!s[1]) begin
                    next_state = LOW;
                    next_prev_state = MID;
                end else if (s[2]) begin
                    next_state = HIGH;
                    next_prev_state = MID;
                end
                fr1 = 1'b1;
                fr2 = 1'b1;
            end
            HIGH: begin
                if (!s[2]) begin
                    next_state = MID;
                    next_prev_state = HIGH;
                end else if (s[3]) begin
                    next_state = FULL;
                    next_prev_state = HIGH;
                end
                fr1 = 1'b1;
            end
            FULL: begin
                if (!s[3]) begin
                    next_state = HIGH;
                    next_prev_state = FULL;
                end
                // No flow rate as the water level is above the highest sensor
            end
        endcase

        if (state != prev_state && state != LOW){
            dfr = 1'b1;
        }
    end
endmodule
