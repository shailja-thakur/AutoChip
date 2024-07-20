module top_module (
	input d,
	input enable,
	output logic q
);

    always @(posedge enable) begin
        q <= d;
    end

endmodule
