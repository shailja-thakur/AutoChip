module top_module(
    input wire clk,
    input wire [7:0] in,
    output wire reg [7:0] pedge);  // Use wire instead of reg for output

    reg [7:0] d_last;  // Declare register for storing previous value

    always @(posedge clk) begin  // Use a sensitivity list
        d_last <= in;  // Store the current value in the register
        pedge <= in & ~d_last;  // Calculate the rising edge detection signal
    end

endmodule
