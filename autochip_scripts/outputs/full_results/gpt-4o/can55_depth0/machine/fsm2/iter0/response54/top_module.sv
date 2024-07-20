module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State declaration
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    // State variables
    state_t state, next_state;

    // Combinational always block to determine the next state
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Clocked always block to update the state
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
