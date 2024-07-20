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
    if (current_state == B)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
