module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 1'b0, B = 1'b1;
reg state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= B;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (in)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
    endcase
end

always @(*) begin
    out = (state == B);
end

endmodule
