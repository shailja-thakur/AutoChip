module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter [1:0] A = 2'd0, B = 2'd1;
reg [1:0] state, next_state;

always @(*) begin
    case (state)
        A: begin
            if (in) next_state = A;
            else next_state = B;
        end
        B: begin
            if (in) next_state = B;
            else next_state = A;
        end
        default: next_state = B;
    endcase
end

always @(posedge clk) begin
    if (reset) state <= B;
    else state <= next_state;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
