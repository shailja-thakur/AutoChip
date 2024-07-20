module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);
	
    reg [7:0] q_temp;  // Temporary variable for storing intermediate values
	
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_temp <= 8'b0;  // Reset all flip-flops to zero when reset is active
        end else begin
            q_temp <= d;  // Assign input value to temporary variable q_temp
        end
    end
	
    assign q = q_temp;  // Connect q_temp to output q
endmodule
