module top_module (
	input clk,
	input in,
	output logic out
);
    // Signal to hold the previous state of the output
    initial begin
        out = 0;  // Initial state is 0
    end

    always_ff @(posedge clk) begin
        out <= in ^ out;  // Toggle on posedge of clk
    end

endmodule
