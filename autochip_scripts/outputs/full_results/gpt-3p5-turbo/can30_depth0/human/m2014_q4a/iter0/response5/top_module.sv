module top_module (
	input d,
	input ena,
	output logic q
);

    logic level;

    always @(posedge ena) begin
        if(ena)
            level <= d;
    end

    always @* begin
        q = level;
    end

endmodule
