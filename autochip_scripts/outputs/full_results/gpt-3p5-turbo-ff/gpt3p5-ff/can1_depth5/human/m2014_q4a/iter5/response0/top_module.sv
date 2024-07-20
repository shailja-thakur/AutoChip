module top_module (
	input d,
	input ena,
	output logic q
);

reg q_delay;

always @ (posedge ena)
begin
    if (ena)
        q_delay <= d;
end

always @ (posedge ena)
begin
    if (ena)
        q <= q_delay;
    else
        q <= 1'b0;
end

endmodule
