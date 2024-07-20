module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
    // Update p based on the input a
    p <= a;
end

always @(negedge clock) begin
    // Update q based on the value of p at the preceding rising edge of clock
    q <= p;
end

endmodule
