module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine the next state
always @(*) begin
    if (state == A) begin
        if (j == 1'b1)
            next_state = B;
        else
            next_state = A;
    end
    else begin // state == B
        if (k == 1'b1)
            next_state = A;
        else
            next_state = B;
    end
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset == 1'b1)
        state <= A;
    else
        state <= next_state;
end

// Assign the output based on the current state
always @(*) begin
    if (state == B)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
