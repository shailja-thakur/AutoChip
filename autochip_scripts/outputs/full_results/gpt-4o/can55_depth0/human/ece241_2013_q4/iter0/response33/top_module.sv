module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // Define the state encoding
    typedef enum logic [1:0] {
        LOW,        // Below s[1]
        BETWEEN1,   // Between s[2] and s[1]
        BETWEEN2,   // Between s[3] and s[2]
        HIGH        // Above s[3]
    } state_t;
    
    state_t state, next_state;

    // State machine to determine the next state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (s)
            3'b111: next_state = HIGH;
            3'b011: next_state = BETWEEN2;
            3'b001: next_state = BETWEEN1;
            3'b000: next_state = LOW;
            default: next_state = LOW;
        endcase
    end

    // Output logic based on the current state and previous state changes
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            case (state)
                HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                BETWEEN2: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    if (next_state == LOW || next_state == BETWEEN1) begin
                        dfr <= 1;
                    end else begin
                        dfr <= 0;
                    end
                end
                BETWEEN1: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    if (next_state == LOW || next_state == BETWEEN2) begin
                        dfr <= 1;
                    end else begin
                        dfr <= 0;
                    end
                end
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                default: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            endcase
        end
    end
endmodule
