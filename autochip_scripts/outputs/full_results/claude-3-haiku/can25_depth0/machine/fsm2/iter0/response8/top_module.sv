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

// Combinational logic to determine next state
always @(*) begin
    case (state)
        STATE_A: next_state = j ? STATE_B : STATE_A;
        STATE_B: next_state = k ? STATE_A : STATE_B;
        default: next_state = STATE_A;
    endcase
end

// Sequential logic to update current state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

// Combinational logic to set the output
always @(*) begin
    out = (state == STATE_B) ? 1'b1 : 1'b0;
end

endmodule
