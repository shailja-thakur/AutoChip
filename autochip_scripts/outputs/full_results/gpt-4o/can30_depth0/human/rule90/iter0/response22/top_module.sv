module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Create a temporary register to store the next state
            reg [511:0] next_state;
            next_state[0] = q[1]; // Boundary condition: q[-1] = 0
            next_state[511] = q[510]; // Boundary condition: q[512] = 0
            for (i = 1; i < 511; i = i + 1) begin
                next_state[i] = q[i-1] ^ q[i+1];
            end
            q <= next_state;
        end
    end

endmodule
