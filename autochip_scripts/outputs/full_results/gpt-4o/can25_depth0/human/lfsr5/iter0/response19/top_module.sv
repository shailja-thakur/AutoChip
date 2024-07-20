module top_module(
    input clk,
    input reset,
    output reg [4:0] q
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset to 1
        end else begin
            // Calculate the feedback bit
            // Taps at positions 5 and 3 correspond to feedback from q[4] and q[2]
            // Next state is formed by shifting right and inputting feedback bit at q[4]
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
