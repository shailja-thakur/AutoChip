module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

reg state, next_state;

parameter A = 1'b0;
parameter B = 1'b1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state, j, k) begin
    case (state)
        A: begin
            if (j) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (k) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        default: next_state = A;
    endcase
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
