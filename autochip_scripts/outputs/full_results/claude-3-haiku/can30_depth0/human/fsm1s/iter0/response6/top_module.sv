module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam A = 1'b0, B = 1'b1;
reg state, next_state;

always @(posedge clk) begin
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
            out = 1'b0;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = A;
            out = 1'b1;
        end
        default: begin
            next_state = B;
            out = 1'b0;
        end
    endcase
end

endmodule
