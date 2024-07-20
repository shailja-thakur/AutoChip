module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Update the state of each cell based on the Rule 110 table
            next_q[0] = q[511] ^ q[1]; // Boundary condition, assume q[512] = 0
            next_q[511] = q[510] ^ q[0]; // Boundary condition, assume q[-1] = 0

            genvar i;
            generate
                for (i = 1; i < 511; i = i + 1) begin : rule_110
                    next_q[i] = (q[i-1] & ~q[i]) | (q[i] & ~q[i+1]) | (q[i+1] & ~q[i-1]);
                end
            endgenerate
            q <= next_q;
        end
    end
endmodule
