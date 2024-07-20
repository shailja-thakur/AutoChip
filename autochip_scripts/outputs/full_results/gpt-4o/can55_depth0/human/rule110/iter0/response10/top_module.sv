module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Temporary register to store next state
    reg [511:0] next_state;
    
    // Next state calculation for one timestep based on Rule 110
    integer i;

    always @(*) begin
        // Assuming boundaries are both zero (off)
        next_state[0] = (q[1]) ? 1 : 0;  // q[-1] is considered 0
        next_state[511] = (q[510]) ? 1 : 0;  // q[512] is considered 0

        // Update all cells based on their left, center, and right neighbors
        for (i = 1; i < 511; i = i + 1) begin
            next_state[i] = ((q[i-1] & q[i] & q[i+1]) == 3'b110) ? 0 :
                            ((q[i-1] & q[i] & ~q[i+1]) == 3'b100) ? 0 :
                            ((~q[i-1] & ~q[i] & ~q[i+1]) == 3'b000) ? 0 :
                            1;
        end
    end
	
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end
endmodule
