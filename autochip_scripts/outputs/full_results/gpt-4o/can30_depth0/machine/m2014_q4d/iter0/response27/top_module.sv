module top_module (
	input  clk,
	input  in,
	output logic out
);
    
    // Initial state of the output signal
    initial out = 0;

    // Always block to handle the toggle flip-flop logic on positive edge of the clock
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
