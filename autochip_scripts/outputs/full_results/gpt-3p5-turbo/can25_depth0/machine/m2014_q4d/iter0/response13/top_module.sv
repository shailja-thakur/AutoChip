module top_module (
	input clk,
	input in,
	output logic out
);

// Create a flip-flop using a reg variable
reg previous_state;

// When the clock signal transitions from low to high
always_ff @(posedge clk)
begin
	// Toggle the output signal based on the input and previous output
	out <= in ^ previous_state;
	
	// Update the previous state variable
	previous_state <= out;
end

endmodule
