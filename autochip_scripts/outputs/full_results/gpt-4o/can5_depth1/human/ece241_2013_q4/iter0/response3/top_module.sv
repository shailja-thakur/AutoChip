module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [2:0] {
        LOW = 3'b000,
        MID_LOW = 3'b001,
        MID_HIGH = 3'b011,
        HIGH = 3'b111
    } state_t;

    state_t state, next_state;
    logic prev_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_state <= LOW;
        end else begin
            state <= next_state;
            prev_state <= state;
        end
    end

    always_comb begin
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;
        next_state = state;

        unique case (s)
            3'b111: begin // Above s[3]
                next_state = HIGH;
            end
            3'b011: begin // Between s[3] and s[2]
                next_state = MID_HIGH;
                fr1 = 1;
                if (prev_state == MID_LOW || prev_state == LOW) dfr = 1;
            end
            3'b001: begin // Between s[2] and s[1]
                next_state = MID_LOW;
                fr1 = 1;
                fr2 = 1;
                if (prev_state == LOW) dfr = 1;
            end
            3'b000: begin // Below s[1]
                next_state = LOW;
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
            default: begin
                next_state = LOW;
            end
        endcase
    end
endmodule
