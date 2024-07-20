module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1'b1) begin
		case(q)
			3'b000: q <= 3'b100;
			3'b100: if(q<3) q <= q + 1; // Increment the value of q by 1
			3'b101: if(q<5) q <= q + 1; // Increment the value of q by 1
			default: q <= 3'b000;
		endcase
	end else begin
		q <= 3'b000;
	end
end

endmodule
