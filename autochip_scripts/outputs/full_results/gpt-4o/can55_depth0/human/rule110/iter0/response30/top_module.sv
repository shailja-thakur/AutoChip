module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal register for storing next state
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Compute the next state for each cell
            next_q[0]    = (q[1] == 1) ? 1 : 0;
            next_q[511]  = (q[510] == 1) ? 1 : 0;
            for (integer i = 1; i < 511; i = i + 1) begin
                next_q[i] = (q[i+1] == 1 && q[i] == 1) ||
                            (q[i+1] == 1 && q[i-1] == 1 && q[i] == 0) ||
                            (q[i] == 1 && q[i-1] == 1 && q[i+1] == 0) ||
                            (q[i+1] == 1 && q[i-1] == 0 && q[i] == 0) ? 1 : 0;
            end
            q <= next_q;
        end
    end
endmodule
