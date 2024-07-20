module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State definitions
parameter STATE_A = 1'b0;
parameter STATE_B = 1'b1;

// Combinational logic for next state
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

// Sequential logic for state update
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= STATE_A;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    case (state)
        STATE_A: out = 1'b0;
        STATE_B: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
