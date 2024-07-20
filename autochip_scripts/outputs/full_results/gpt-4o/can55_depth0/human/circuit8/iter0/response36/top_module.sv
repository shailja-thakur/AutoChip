module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

    // A sequential circuit with registers p and q driven by input a and clock
    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) begin
                p <= 1'b1;
            end else begin
                p <= 1'b0;
            end
        end else begin
            // This section clocks when clock signal goes low (falling edge)
            q <= p;
        end
    end

endmodule
