module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
reg next_state;

// State definition
parameter A = 1'b0;
parameter B = 1'b1;

// Combinational logic to determine next state
always @(*) begin
    case (state)
        A: begin
            if (j)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (k)
                next_state = A;
            else
                next_state = B;
        end
        default: next_state = A;
    endcase
end

// Sequential logic to update current state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
