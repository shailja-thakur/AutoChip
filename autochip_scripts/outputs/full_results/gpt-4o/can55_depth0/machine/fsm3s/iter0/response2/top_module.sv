module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state values
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = in ? STATE_B : STATE_A;
            STATE_B: next_state = in ? STATE_B : STATE_C;
            STATE_C: next_state = in ? STATE_D : STATE_A;
            STATE_D: next_state = in ? STATE_B : STATE_C;
            default: next_state = STATE_A; // Default case to handle unexpected issues
        endcase
    end

    // Output logic
    always @(*) begin
        out = (current_state == STATE_D) ? 1'b1 : 1'b0;
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end
    
endmodule
