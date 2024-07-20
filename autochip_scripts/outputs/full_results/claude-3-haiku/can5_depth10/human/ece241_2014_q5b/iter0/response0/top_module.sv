module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// One-hot encoding for the states
parameter A = 2'b01;
parameter B = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        A: begin
            if (x)
                next_state = B;
            z = x;
        end
        B: begin
            if (~x)
                z = 1'b1;
            else
                z = 1'b0;
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

endmodule
