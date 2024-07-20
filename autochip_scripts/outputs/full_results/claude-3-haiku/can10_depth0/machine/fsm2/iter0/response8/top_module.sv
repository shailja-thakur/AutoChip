module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State definitions
parameter A = 1'b0;
parameter B = 1'b1;

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (j == 1'b1)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (k == 1'b1)
                next_state = A;
            else
                next_state = B;
        end
        default: next_state = A;
    endcase
end

// State update
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
