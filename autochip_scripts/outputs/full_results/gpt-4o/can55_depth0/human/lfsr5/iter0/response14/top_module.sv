module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset the LFSR to 1
        end
        else begin
            // Calculate the feedback bit as the XOR of the tapped bits
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
