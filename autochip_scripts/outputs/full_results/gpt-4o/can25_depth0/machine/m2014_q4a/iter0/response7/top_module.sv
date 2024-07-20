module top_module (
	input d,
	input ena,
	output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // If ena is not high, q remains unchanged due to blocking assignment in combinational logic
end

endmodule
