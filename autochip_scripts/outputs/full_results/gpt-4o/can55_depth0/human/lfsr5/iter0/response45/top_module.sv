module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // On reset, set the LFSR to 1
        end 
        else begin
            // Compute the feedback from taps at position 5 and 3
            // Tap positions are q[4] (bit 5) and q[2] (bit 3)
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
