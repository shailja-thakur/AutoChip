module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset state to 1
        end else begin
            q[4] <= q[0];                  // q[4] gets the value of q[0]
            q[3] <= q[4];                  // q[3] shifts from q[4]
            q[2] <= q[3];                  // q[2] shifts from q[3]
            q[1] <= q[2];                  // q[1] shifts from q[2]
            q[0] <= q[0] ^ q[3];           // Feedback: q[0] XOR q[3]
        end
    end
endmodule
