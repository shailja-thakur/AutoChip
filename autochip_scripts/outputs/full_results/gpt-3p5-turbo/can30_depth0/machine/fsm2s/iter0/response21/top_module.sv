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

always @(posedge clk) begin
    if (reset)
        state <= A;
    else 
        state <= next_state;
end

always @(j, k, state) begin
    case (state)
        A: begin
            if (j)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (k)
                next_state = A;
            else
                next_state = B;
        end
        default: next_state = A;
    endcase
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
