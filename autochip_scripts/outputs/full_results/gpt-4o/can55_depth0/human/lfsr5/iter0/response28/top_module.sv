module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    wire feedback;

    // XOR the tap positions with the output bit (bit 4 which is the MSB)
    assign feedback = q[4] ^ q[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous reset: set LFSR to 5'b00001
            q <= 5'b00001;
        end else begin
            // Shift and apply feedback
            q <= {q[3:0], feedback};
        end
    end
endmodule
