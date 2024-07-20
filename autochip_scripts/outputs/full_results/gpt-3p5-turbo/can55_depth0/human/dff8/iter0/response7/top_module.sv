module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_next;  // Next state of q

always @(posedge clk) begin
    q <= q_next;  // Update q with the next state
end

integer i;
reg [7:0] d_ff;  // Individual input of each D flip flop

initial begin
    q_next = 8'b0;  // Initialize q_next with all zeros

    for (i = 0; i < 8; i = i + 1) begin
        q_next[i] <= d_ff[i];  // Assign the individual input to the next state
    end
end

always @(posedge clk) begin
    for (i = 0; i < 8; i = i + 1) begin
        d_ff[i] <= d[i];  // Update the individual input of each D flip flop
    end
end

endmodule
