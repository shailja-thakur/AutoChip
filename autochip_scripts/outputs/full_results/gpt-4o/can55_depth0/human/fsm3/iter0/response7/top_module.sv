module top_module (
    input clk,
    input in,
    input areset,
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

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in) ? STATE_B : STATE_A;
            STATE_B: next_state = (in) ? STATE_B : STATE_C;
            STATE_C: next_state = (in) ? STATE_D : STATE_A;
            STATE_D: next_state = (in) ? STATE_B : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A, STATE_B, STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
