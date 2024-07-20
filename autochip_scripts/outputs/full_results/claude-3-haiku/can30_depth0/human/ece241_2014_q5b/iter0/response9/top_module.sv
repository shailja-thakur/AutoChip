module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// One-hot encoding for the states
parameter A = 2'b01, B = 2'b10;
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    // Default next state and output
    next_state = state;
    z = 0;

    case (state)
        A: begin
            if (x) begin
                next_state = B;
                z = 1;
            end
        end
        B: begin
            if (~x) begin
                z = 1;
            end else begin
                z = 0;
            end
        end
    endcase
end

endmodule
