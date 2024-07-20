module top_module (
	input d,
	input ena,
	output logic q
);

always @ (posedge ena)
begin
    if (ena)
        q <= d;
end

endmodule
