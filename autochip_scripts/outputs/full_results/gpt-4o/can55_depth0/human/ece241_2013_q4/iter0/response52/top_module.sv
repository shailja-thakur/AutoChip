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
        LOW = 2'd0,
        MID_LOW = 2'd1,
        MID_HIGH = 2'd2,
        HIGH = 2'd3
    } state_t;

    state_t current_state, next_state;
    reg previous_higher;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            previous_higher <= 1'b0;
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        previous_higher <= s[3];
    end

    always_comb begin
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;
        case (current_state)
            LOW: begin
                if (s[1] && !s[2] && !s[3]) begin
                    next_state = MID_LOW;
                end else if (s[1] && s[2] && !s[3]) begin
                    next_state = MID_HIGH;
                end else if (s[1] && s[2] && s[3]) begin
                    next_state = HIGH;
                end else begin
                    next_state = LOW;
                    fr1 = 1;
                    fr2 = 1;
                    fr3 = 1;
                end
            end
            
            MID_LOW: begin
                if (!s[1] && !s[2] && !s[3]) begin
                    next_state = LOW;
                end else if (s[1] && s[2] && !s[3]) begin
                    next_state = MID_HIGH;
                end else if (s[1] && s[2] && s[3]) begin
                    next_state = HIGH;
                end else begin
                    next_state = MID_LOW;
                    fr1 = 1;
                    fr2 = 1;
                    dfr = !previous_higher;
                end
            end
            
            MID_HIGH: begin
                if (!s[1] && !s[2] && !s[3]) begin
                    next_state = LOW;
                end else if (s[1] && !s[2] && !s[3]) begin
                    next_state = MID_LOW;
                end else if (s[1] && s[2] && s[3]) begin
                    next_state = HIGH;
                end else begin
                    next_state = MID_HIGH;
                    fr1 = 1;
                end
            end
            
            HIGH: begin
                if (!s[1] && !s[2] && !s[3]) begin
                    next_state = LOW;
                end else if (s[1] && !s[2] && !s[3]) begin
                    next_state = MID_LOW;
                end else if (s[1] && s[2] && !s[3]) begin
                    next_state = MID_HIGH;
                end else begin
                    next_state = HIGH;
                end
            end
            
            default: next_state = LOW;
        endcase
    end

endmodule
