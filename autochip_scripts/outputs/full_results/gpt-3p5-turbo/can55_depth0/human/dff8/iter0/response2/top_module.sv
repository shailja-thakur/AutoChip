module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] dff_q [0:7]; // Declare an array of 8 D flip-flops

    always @(posedge clk) begin
        // Update the output q based on the input d
        for (int i = 0; i < 8; i = i + 1) begin
            dff_q[i] <= d[i];
        end
        q <= dff_q;
    end

endmodule
