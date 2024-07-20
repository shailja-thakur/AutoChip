module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;
localparam A = 1'b0, B = 1'b1;

always @(*) begin
    case (state)
        A: begin
            if (j) next_state = B;
            else next_state = A;
        end
        B: begin
            if (k) next_state = A;
            else next_state = B;
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
        out <= 1'b0;
    end
    else begin
        state <= next_state;
        out <= (state == B) ? 1'b1 : 1'b0;
    end
end

endmodule
