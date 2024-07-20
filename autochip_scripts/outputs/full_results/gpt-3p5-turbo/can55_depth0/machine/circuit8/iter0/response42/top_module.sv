module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

reg prev_a;

always @(negedge clock) begin
    q <= a;
end

always @(posedge clock) begin
    if (clock) begin
        p <= a;
    end
    prev_a <= a;
end

endmodule
