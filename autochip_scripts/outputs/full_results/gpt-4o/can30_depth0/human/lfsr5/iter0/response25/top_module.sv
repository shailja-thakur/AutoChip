module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;  // Reset the LFSR to the state 1
        end else begin
            // Apply the taps and shift
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
