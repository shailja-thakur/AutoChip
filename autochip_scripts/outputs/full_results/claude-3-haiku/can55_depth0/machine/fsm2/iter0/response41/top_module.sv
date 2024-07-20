module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        A: begin
            if (j)
                state = B;
            else
                state = A;
        end
        B: begin
            if (k)
                state = A;
            else
                state = B;
        end
        default: state = A;
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= state;
end

// Output logic
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
