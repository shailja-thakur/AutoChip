module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

// Declare internal signals
reg q_reg;
reg state_reg;

// Sequential logic
always @(posedge clk) begin
    if (state_reg == 1'b0 && a == 1'b1 && b == 1'b0) begin
        q_reg <= 1'b1;
        state_reg <= 1'b1;
    end else if (state_reg == 1'b1 && a == 1'b0 && b == 1'b1) begin
        q_reg <= 1'b0;
        state_reg <= 1'b0;
    end else begin
        q_reg <= q_reg;
        state_reg <= state_reg;
    end
end

// Assign outputs
assign q = q_reg;
assign state = state_reg;

endmodule
