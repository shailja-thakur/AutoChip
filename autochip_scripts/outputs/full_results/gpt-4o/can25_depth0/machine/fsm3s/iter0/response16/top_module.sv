module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = in ? STATE_B : STATE_A;
            STATE_B: next_state = in ? STATE_B : STATE_C;
            STATE_C: next_state = in ? STATE_D : STATE_A;
            STATE_D: next_state = in ? STATE_B : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always @(*) begin
        out = (current_state == STATE_D);
    end

endmodule
