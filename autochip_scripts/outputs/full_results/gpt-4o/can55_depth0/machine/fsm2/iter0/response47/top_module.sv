module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define state encoding
    typedef enum reg [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;
    
    state_t state, next_state;

    // Combinational always block to determine next state
    always @(*) begin
        case (state)
            STATE_A: next_state = (j) ? STATE_B : STATE_A;
            STATE_B: next_state = (k) ? STATE_A : STATE_B;
            default: next_state = STATE_A;
        endcase
    end

    // Clocked always block to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == STATE_B);
    end
endmodule
