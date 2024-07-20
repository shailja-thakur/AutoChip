module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // Next state logic (Combinational)
    always @(*) begin
        case (current_state)
            STATE_A: next_state = j ? STATE_B : STATE_A;
            STATE_B: next_state = k ? STATE_A : STATE_B;
            default: next_state = STATE_A;
        endcase
    end

    // State transition logic (Sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(current_state) begin
        out = (current_state == STATE_B);
    end
endmodule
