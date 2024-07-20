module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;
parameter STATE_A = 1'b0, STATE_B = 1'b1;

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
        default: begin
            next_state = STATE_A;
        end
    endcase
end

// Clocked always block to update the state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= STATE_A;
    else
        state <= next_state;
end

// Assign the output based on the current state
always @(*) begin
    if (state == STATE_B)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
