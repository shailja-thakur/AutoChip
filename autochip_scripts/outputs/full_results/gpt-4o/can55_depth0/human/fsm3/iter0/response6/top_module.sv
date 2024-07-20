module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State Registers
    state_t state, next_state;

    // State Transition
    always @(*) begin
        case (state)
            STATE_A: begin
                next_state = (in) ? STATE_B : STATE_A;
                out = 1'b0;
            end
            STATE_B: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b0;
            end
            STATE_C: begin
                next_state = (in) ? STATE_D : STATE_A;
                out = 1'b0;
            end
            STATE_D: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_A;
                out = 1'b0;
            end
        endcase
    end

    // State Flip-Flops with Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

endmodule
