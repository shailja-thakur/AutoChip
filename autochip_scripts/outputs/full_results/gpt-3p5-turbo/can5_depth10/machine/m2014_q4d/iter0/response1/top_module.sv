module top_module (
	input clk,
	input in,
	output logic out
);
    logic prev_out; // previous output signal
    
    always_ff @(posedge clk) begin
        out <= in ^ prev_out; // toggle output signal
        prev_out <= out; // store current output signal for next clock cycle
    end
endmodule
