module top_module (
	input d,
	input ena,
	output logic q
);

always@(ena) begin
    if (ena == 1'b1)
        q <= d;
end

endmodule
