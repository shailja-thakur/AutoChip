module top_module (
	input d,
	input ena,
	output logic q
);

// Internal register to hold the value of the output
logic q_reg;

always @(*) begin
    if (ena) begin
        q_reg = d;
    end
end

assign q = q_reg;

endmodule
