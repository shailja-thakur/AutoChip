module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;

            // Calculate the next state for each cell
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Left boundary case
                    next_q[i] = 0 ? (q[i] ? (q[i+1] ? 0 : 1) : (q[i+1] ? 1 : 0));
                end else if (i == 511) begin
                    // Right boundary case
                    next_q[i] = (q[i-1] ? (q[i] ? 1 : 0) : (q[i] ? 1 : 0)) ? 0 : 0;
                end else begin
                    // General case
                    next_q[i] = (q[i-1] ? (q[i] ? (q[i+1] ? 0 : 1) : 0) : (q[i] ? 1 : (q[i+1] ? 1 : 0)));
                    // Alternatively, the above line can be written as:
                    // next_q[i] = (~q[i+1] & q[i-1] & q[i]) | (q[i+1] & ~q[i-1] & ~q[i]) | (q[i-1] & ~q[i] & ~q[i-1]) | (q[i-1] & q[i+1] & ~q[i]);
                end
            end

            q <= next_q;
        end
    end
endmodule
