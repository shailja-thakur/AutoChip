module top_module (
	input d,
	input ena,
	output logic q
);

always_comb begin
    if (ena)
        q = d;
    // When 'ena' is low, 'q' should retain its value.
    // In an actual FPGA/ASIC, we would need latches or flip-flops which are sequential elements.
end

endmodule
