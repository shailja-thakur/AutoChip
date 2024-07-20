module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock or negedge clock) begin
    if (~clock) begin
        q <= p;
    end
end

always @(posedge clock) begin
    p <= a;
end

endmodule
