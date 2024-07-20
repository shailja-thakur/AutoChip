module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

    // internal signal for the flip flop
    logic q_internal;

    // D flip flop instantiation
    always_ff @(posedge clk or negedge ar)
    begin
        if (~ar)
            q_internal <= 0; // reset, q_internal is cleared to 0
        else
            q_internal <= d; // flip, q_internal is set to d
    end

    // output assignment
    assign q = q_internal;

endmodule
