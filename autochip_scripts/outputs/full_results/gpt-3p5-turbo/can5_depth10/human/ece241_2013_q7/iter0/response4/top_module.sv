module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

always @(posedge clk) begin
    if (j && k) begin // If both j and k are high
        Q <= ~Q;
    end else if (j) begin // If j is high and k is low
        Q <= 1;
    end else if (k) begin // If k is high and j is low
        Q <= 0;
    end
    // Otherwise, do nothing and retain the previous value of Q
end

endmodule
