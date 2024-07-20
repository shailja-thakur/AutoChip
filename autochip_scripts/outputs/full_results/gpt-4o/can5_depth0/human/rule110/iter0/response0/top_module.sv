module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
    // Temporary register to store next state
    reg [511:0] next_q;

    // Combinational logic to calculate next state 
    always @(*) begin
        // Boundary conditions: q[-1] and q[512] are both zero (off)
        next_q[0] = (q[1]) ? 1 : 0;
        for (int i = 1; i < 511; i = i + 1) begin
            next_q[i] = (q[i+1] && !q[i-1]) || (!q[i+1] && q[i-1]) || (q[i-1] && q[i+1] && !q[i]);
        end
        next_q[511] = (q[510]) ? 1 : 0;
    end

    // Sequential logic
    always @(posedge clk) begin
        if (load) 
            q <= data;
        else 
            q <= next_q;
    end
endmodule
