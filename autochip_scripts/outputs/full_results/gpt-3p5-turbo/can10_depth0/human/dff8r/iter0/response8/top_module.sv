module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    reg [7:0] q_temp; // Temporary variable for holding intermediate values
    
    always @(posedge clk) begin
        if (reset) begin
            q_temp <= 8'b0; // Reset all flip-flops to zero
        end else begin
            q_temp <= d; // Assign input to temporary variable
        end
    end
    
    assign q = q_temp; // Assign temporary variable to output
    
endmodule
