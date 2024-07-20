module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal wires
    wire [511:0] q_next;

    // Assign the next state of each cell based on the current state and neighbors
    assign q_next[0] = (q[511] & q[0] & q[1]) ^ (~q[511] & ~q[0] & ~q[1]);
    assign q_next[511] = (~q[510] & ~q[511] & ~q[0]) ^ (q[510] & q[511] & q[0]);
    genvar i;
    generate
        for (i = 1; i < 511; i = i + 1) begin : update_cells
            assign q_next[i] = (~q[i-1] & q[i] & q[i+1]) ^ (q[i-1] & ~q[i] & ~q[i+1]);
        end
    endgenerate

    // Load the initial state if load input is high
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

endmodule
