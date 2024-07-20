module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states
    typedef enum reg [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    reg state, next_state;

    // State transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = in ? STATE_A : STATE_B;
            STATE_B: next_state = in ? STATE_B : STATE_A;
            default: next_state = STATE_B;
        endcase
    end

    // Output logic
    always @(*) begin
        out = (state == STATE_B);
    end

endmodule
