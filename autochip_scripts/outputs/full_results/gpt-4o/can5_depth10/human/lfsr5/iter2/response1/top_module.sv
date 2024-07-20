module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    wire feedback;

    assign feedback = q[4] ^ q[2];  // Taps at bit positions 5 and 3

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q <= {q[3:0], feedback};  // Shift and feed back
        end
    end
endmodule
