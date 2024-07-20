module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

    // Define internal signals
    reg [15:0] q_internal;
    
    // Assign the output signals
    assign ena = q[15:13];
    assign q = q_internal;
    
    // Clock edge detection
    always @(posedge clk) begin
        if (reset) begin
            q_internal <= 16'b0000;
        end else begin
            if (ena[0]) begin
                q_internal[3:0] <= (q_internal[3:0] == 16'b1001) ? 16'b0000 : q_internal[3:0] + 4'b0001;
            end
            if (ena[1]) begin
                q_internal[7:4] <= (q_internal[7:4] == 16'b1001) ? 16'b0000 : q_internal[7:4] + 4'b0001;
            end
            if (ena[2]) begin
                q_internal[11:8] <= (q_internal[11:8] == 16'b1001) ? 16'b0000 : q_internal[11:8] + 4'b0001;
            end
        end
    end

endmodule
