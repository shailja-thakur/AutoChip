module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
    // Define states
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    // State variables
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (state == STATE_B);
    end

endmodule
