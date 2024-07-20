module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

parameter A = 2'b00, B = 2'b01;

always @(posedge clk, posedge areset) begin
    if (areset)
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
        default:
            next_state = B;
    endcase
end

endmodule
