module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_temp; // Temporary variable to store the intermediate values
    
    always @(posedge clk) begin
        q_temp <= d; // Assign the input to the temporary variable on positive edge of clk
    end
    
    // Assign the temporary variable to the output
    assign q = q_temp;
endmodule
