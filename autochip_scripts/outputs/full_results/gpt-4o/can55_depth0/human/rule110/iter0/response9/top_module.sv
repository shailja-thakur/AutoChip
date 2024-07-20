module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_next;

    // Function to calculate the next state based on Rule 110
    function next_state;
        input left, center, right;
        begin
            next_state = (left & center & ~right) |
                         (left & ~center & right) |
                         (~left & center) |
                         (~left & right);
        end
    endfunction

    always @ (posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q_next[0] = next_state(1'b0, q[0], q[1]); // Boundary condition: left neighbour is 0
            q_next[511] = next_state(q[510], q[511], 1'b0); // Boundary condition: right neighbour is 0

            // Compute the next state for inner cells
            for (int i = 1; i < 511; i = i + 1) begin
                q_next[i] = next_state(q[i-1], q[i], q[i+1]);
            end

            q <= q_next;
        end
    end

endmodule
