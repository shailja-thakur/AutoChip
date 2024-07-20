module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,  // Signal to enable incrementing of upper three digits
    output reg [15:0] q);  // 16-bit output representing four digits (q[3:0], q[7:4], q[11:8], q[15:12])
    
    always @(posedge clk) begin
        if (reset) begin
            ena <= 3'b000; // Reset enable signal
            q <= 16'b0000; // Reset output
        end
        else begin
            if (ena < 3'b100)
                ena <= ena + 1; // Increment enable signal for upper three digits
            else
                ena <= 3'b000;
                
            if (ena[0]) q[15:12] <= q[15:12] + 1; // Increment ones digit (q[3:0])

            if (ena[1]) q[11:8] <= q[11:8] + 1;   // Increment tens digit (q[7:4])

            if (ena[2]) q[7:4] <= q[7:4] + 1;     // Increment hundreds digit (q[11:8])

            if (ena[3]) q[3:0] <= q[3:0] + 1;     // Increment thousands digit (q[15:12])
        end
    end
endmodule
