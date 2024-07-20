module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state, next_state;
localparam A = 1'b0, B = 1'b1;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        B: begin
            out = 1'b1;
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        A: begin
            out = 1'b0;
            if (in)
                next_state = A;
            else
                next_state = B;
        end
        default: begin
            out = 1'b0;
            next_state = B;
        end
    endcase
end

endmodule
