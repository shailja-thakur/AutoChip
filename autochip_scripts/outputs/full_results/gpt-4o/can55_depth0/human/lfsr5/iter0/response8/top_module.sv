module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Initialize to any non-zero value, here it's 1
        end else begin
            // Shift the register
            q <= {q[3] ^ q[4], q[4:1]};
        end
    end
    
endmodule
