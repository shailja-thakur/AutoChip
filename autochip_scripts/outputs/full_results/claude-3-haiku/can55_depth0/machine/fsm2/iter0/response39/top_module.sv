module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 0, B = 1;

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
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= state;
end

// Combinational logic to set the output
always @(*) begin
    if (state == B)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
