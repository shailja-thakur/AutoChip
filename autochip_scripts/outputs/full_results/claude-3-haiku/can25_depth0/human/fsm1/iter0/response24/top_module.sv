module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg current_state, next_state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= B;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        B: begin
            out = 1'b1;
            if (in == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        A: begin
            out = 1'b0;
            if (in == 1'b0)
                next_state = B;
            else
                next_state = A;
        end
    endcase
end

endmodule
