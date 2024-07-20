module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// Define the two states
localparam A = 0, B = 1;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        A: begin
            if (j) next_state = B;
            else next_state = A;
        end
        B: begin
            if (k) next_state = A;
            else next_state = B;
        end
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Output logic
always @(*) begin
    if (state == B)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
