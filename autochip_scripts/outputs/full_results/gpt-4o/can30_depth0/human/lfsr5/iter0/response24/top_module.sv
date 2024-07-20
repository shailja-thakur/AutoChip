module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;          // On reset, set the LFSR to the state 1
        end else begin
            q[4] <= q[0];           // Shift the register
            q[3] <= q[4] ^ q[0];    // Tap positions 5 and 3
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[1];
        end
    end

endmodule
