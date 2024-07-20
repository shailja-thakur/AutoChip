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
    
    reg [1:0] state, next_state;
    reg previous_higher;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            previous_higher <= 0;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;

            case(state)
                HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                MID_HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= previous_higher;
                end
                MID_LOW: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= previous_higher;
                end
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            endcase

            previous_higher <= (state < next_state) ? 1'b1 : 1'b0;
        end
    end

    always @(*) begin
        case ({s[3], s[2], s[1]})
            3'b111: next_state = HIGH;
            3'b011: next_state = MID_HIGH;
            3'b001: next_state = MID_LOW;
            3'b000: next_state = LOW;
            default: next_state = LOW; // Default to safe state
        endcase
    end
endmodule
