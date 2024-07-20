module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding for the state machine
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg previous_increase;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
            previous_increase <= 0;
        end
        else begin
            current_state <= next_state;
            
            case (next_state)
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                MID_LOW: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= previous_increase;
                end
                MID_HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= previous_increase;
                end
                HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end

    always @* begin
        next_state = current_state;
        previous_increase = 0;

        case (current_state)
            LOW: begin
                if (s[1] && !s[2] && !s[3]) begin
                    next_state = MID_LOW;
                end
            end
            MID_LOW: begin
                if (s[1] && s[2] && !s[3]) begin
                    next_state = MID_HIGH;
                    previous_increase = 1;
                end
                else if (!s[1]) begin
                    next_state = LOW;
                end
            end
            MID_HIGH: begin
                if (s[1] && s[2] && s[3]) begin
                    next_state = HIGH;
                end
                else if (!s[2]) begin
                    next_state = MID_LOW;
                end
            end
            HIGH: begin
                if (!s[3]) begin
                    next_state = MID_HIGH;
                    previous_increase = 1;
                end
            end
        endcase
    end

endmodule
