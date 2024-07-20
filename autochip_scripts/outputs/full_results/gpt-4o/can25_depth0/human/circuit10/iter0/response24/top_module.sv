module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
    // Combinational logic for next state and output based on inputs a and b
    if ((a == 1 && b == 0) || (a == 0 && b == 1)) begin
        state <= 1;
        q <= 1;
    end else if (a == 1 && b == 1) begin
        state <= 0;
        q <= 0;
    end else begin
        state <= 0;
        q <= 0;
    end
end

endmodule
