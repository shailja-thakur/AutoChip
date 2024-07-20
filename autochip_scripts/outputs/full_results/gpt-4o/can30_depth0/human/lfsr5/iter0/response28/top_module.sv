module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Initialize to 1 on reset
        end else begin
            q <= {q[3:0], q[4] ^ q[2]};  // Shift and apply taps at positions 5 (q[4]) and 3 (q[2])
        end
    end

endmodule
