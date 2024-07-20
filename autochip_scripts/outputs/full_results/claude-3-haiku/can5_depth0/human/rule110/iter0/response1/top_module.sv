module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    // Temporary variables to store the next state of each cell
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Compute the next state of each cell based on the Rule 110 logic
            next_q[0] <= (q[1] & q[0]) | (~q[1] & q[0]) | (q[1] & ~q[0]);
            for (int i = 1; i < 511; i++) begin
                next_q[i] <= (q[i+1] & q[i]) | (~q[i+1] & q[i]) | (q[i+1] & ~q[i]);
            end
            next_q[511] <= (0 & q[511]) | (~0 & q[511]) | (0 & ~q[511]);
            q <= next_q;
        end
    end

endmodule
