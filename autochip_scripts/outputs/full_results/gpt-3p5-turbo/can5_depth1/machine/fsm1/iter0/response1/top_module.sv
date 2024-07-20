module top_module (
	input clk,
	input in,
	input areset,
	output out
);
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1; // reset state to B
        end else begin
            if (state == 1'b1) begin
                state <= in ? 1'b1 : 1'b0; // if in is high, stay in state B, otherwise transition to state A
            end else begin
                state <= in ? 1'b0 : 1'b1; // if in is high, stay in state A, otherwise transition to state B
            end
        end
    end
    
    assign out = (state == 1'b1) ? 1'b1 : 1'b0; // output is high when state is B, low otherwise
endmodule
