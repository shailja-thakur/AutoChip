module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        S1101 = 3'b100
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            IDLE: next_state = data ? S1 : IDLE;
            S1: next_state = data ? S11 : IDLE;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? S1101 : IDLE;
            S1101: next_state = S1101;  // Stay in this state once the sequence is detected
            default: next_state = IDLE;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (next_state == S1101) begin
                start_shifting <= 1;
            end
        end
    end
    
endmodule
