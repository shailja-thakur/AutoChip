module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(state, x) begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
            z = x;
        end
        B: begin
            if (x)
                next_state = B;
            else
                next_state = B;
            z = ~x;
        end
    endcase
end

endmodule
