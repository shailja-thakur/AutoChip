module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;  // Reset LFSR to 1
        end else begin
            q <= {q[3], q[4] ^ q[2], q[1:0], q[4]}; // LFSR logic
        end
    end
endmodule
