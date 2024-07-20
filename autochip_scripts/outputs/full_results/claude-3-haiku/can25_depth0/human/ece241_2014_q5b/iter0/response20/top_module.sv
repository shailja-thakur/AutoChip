module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 2'b01;
parameter B = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (x == 1'b0)
                next_state = B;
            else
                next_state = B;
        end
        default: next_state = A;
    endcase
end

assign z = (state == B && x == 1'b0) ? 1'b1 : 1'b0;

endmodule
