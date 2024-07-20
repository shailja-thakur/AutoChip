module top_module (
	input wire clock,
	input wire a, 
	output wire reg p,
	output wire reg q
);

reg p_reg, q_reg;
always @(posedge clock or negedge clock) begin
    if (~clock) begin
        q_reg <= a;
    end
end

always @(a) begin
    if (clock) begin
        p_reg <= a;
    end
end

assign p = p_reg;
assign q = q_reg;

endmodule
