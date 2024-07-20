module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State declaration
    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID1 = 2'b01,
        MID2 = 2'b10,
        HIGH = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg prev_lower;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_lower <= 1'b1;
        end else begin
            state <= next_state;
            if (next_state > state)
                prev_lower <= 1'b0;
            else if (next_state < state)
                prev_lower <= 1'b1;
        end
    end

    // Next state logic
    always @(*) begin
        case (s)
            3'b111: next_state = HIGH;
            3'b011: next_state = MID2;
            3'b001: next_state = MID1;
            default: next_state = LOW;
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            fr3 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            case (next_state)
                HIGH: begin
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end
                MID2: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= (prev_lower == 1'b1) ? 1'b1 : 1'b0;
                end
                MID1: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b0;
                    dfr <= (prev_lower == 1'b1) ? 1'b1 : 1'b0;
                end
                LOW: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b1;
                    dfr <= 1'b1;
                end
            endcase
        end
    end
    
endmodule
