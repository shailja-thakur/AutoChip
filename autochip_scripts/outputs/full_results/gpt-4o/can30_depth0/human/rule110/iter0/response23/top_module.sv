module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            reg [511:0] next_state;
            // Define the next state for each cell
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Boundary condition
                    next_state[i] = (q[0] & q[1]) | (q[1] & ~q[0]) | (~q[0] & q[1]);
                end else if (i == 511) begin
                    // Boundary condition
                    next_state[i] = (q[510] & q[511]) | (q[510] & ~q[511]) | (~q[510] & q[510]);
                end else begin
                    // General case
                    next_state[i] = (q[i-1] & q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]) | (q[i-1] & ~q[i] & ~q[i+1]) | (~q[i-1] & q[i] & q[i+1]);
                end
            end
            q <= next_state;
        end
    end
endmodule
