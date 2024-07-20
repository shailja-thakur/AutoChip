module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end else begin
        // Increment the ones digit
        q[3:0] <= (q[3:0] == 4'b1001) ? 4'b0000 : q[3:0] + 1'b1;
        
        // Increment the tens digit when the ones digit rolls over
        q[7:4] <= (q[3:0] == 4'b1001) ? ((q[7:4] == 4'b1001) ? 4'b0000 : q[7:4] + 1'b1) : q[7:4];
        
        // Increment the hundreds digit when the tens digit rolls over
        q[11:8] <= (q[7:4] == 4'b1001 && q[3:0] == 4'b1001) ? ((q[11:8] == 4'b1001) ? 4'b0000 : q[11:8] + 1'b1) : q[11:8];
        
        // Increment the thousands digit when the hundreds digit rolls over
        q[15:12] <= (q[11:8] == 4'b1001 && q[7:4] == 4'b1001 && q[3:0] == 4'b1001) ? ((q[15:12] == 4'b1001) ? 4'b0000 : q[15:12] + 1'b1) : q[15:12];
    end
end

// Generate the enable signals for the upper three digits
assign ena[1] = (q[3:0] == 4'b1001);
assign ena[2] = (q[7:4] == 4'b1001 && q[3:0] == 4'b1001);
assign ena[3] = (q[11:8] == 4'b1001 && q[7:4] == 4'b1001 && q[3:0] == 4'b1001);

endmodule
