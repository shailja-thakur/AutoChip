module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

reg state, next_state;

parameter A = 0;
parameter B = 1;

always @(posedge clk or negedge reset) begin
    if (reset == 0) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state, j, k) begin
    if (state == A) begin
        if (j == 1) begin
            next_state <= B;
        end else begin
            next_state <= A;
        end
    end else begin
        if (k == 1) begin
            next_state <= A;
        end else begin
            next_state <= B;
        end
    end
end

assign out = (state == B) ? 1 : 0;

endmodule
