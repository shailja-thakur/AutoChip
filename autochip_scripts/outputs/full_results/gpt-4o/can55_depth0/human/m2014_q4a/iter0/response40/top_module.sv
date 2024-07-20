module top_module (
	input d,
	input ena,
	output logic q
);

always @(d or ena) begin
    if (ena) begin
        q = d;
    end
    // If ena is not active, q retains its value
end

endmodule
