module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Temporary register for next state calculations
    reg [511:0] next_q;

    // Synchronous process to update the state on each clock cycle
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate the next state for each cell
            next_q[0] = (q[0] == 0 && q[1] == 1) || (q[0] == 0 && q[1] == 0 && q[2] == 1);
            next_q[511] = (q[511] == 0 && q[510] == 1) || (q[511] == 0 && q[509] == 1 && q[510] == 1);

            // Calculate for middle cells
            integer i;
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] = (q[i - 1] != q[i + 1]) || (q[i]);
            end

            q <= next_q;
        end
    end
endmodule
