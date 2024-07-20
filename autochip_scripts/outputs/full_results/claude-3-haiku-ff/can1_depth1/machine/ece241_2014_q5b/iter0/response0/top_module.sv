module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else begin
        case (state)
            A: begin
                if (x)
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                state <= B;
            end
        endcase
    end
end

always @(*) begin
    if ((state == A && x) || (state == B && !x))
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
