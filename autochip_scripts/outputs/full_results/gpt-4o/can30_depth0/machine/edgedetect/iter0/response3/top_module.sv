module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] d_last;
    
    // Always block triggered on the rising edge of the clock
    always @(posedge clk) begin
        // Calculate the rising edge detection
        pedge <= in & ~d_last;
        // Store the current input value for the next clock cycle
        d_last <= in;
    end

endmodule
