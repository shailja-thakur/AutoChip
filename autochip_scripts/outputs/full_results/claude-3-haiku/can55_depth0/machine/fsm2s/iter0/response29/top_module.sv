module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg current_state, next_state;

// State definitions
parameter A = 1'b0, B = 1'b1;

// Update current state on clock edge
always @(posedge clk) begin
    if (reset)
        current_state <= A;
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    case (current_state)
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

// Output logic
always @(*) begin
    case (current_state)
        A: out = 1'b0;
        B: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
