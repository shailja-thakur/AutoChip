module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
    p <= a; // p takes the value of a on the rising edge of the clock
end

always @(negedge clock) begin
    q <= p; // q takes the value of p on the falling edge of the clock
end

endmodule
