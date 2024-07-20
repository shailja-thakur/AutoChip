module top_module (
	input d,
	input ena,
	output logic q
);

always @ (posedge ena)
begin
    if (ena)
        q <= d;
    else
        q <= 1'b0;
end

endmodule
