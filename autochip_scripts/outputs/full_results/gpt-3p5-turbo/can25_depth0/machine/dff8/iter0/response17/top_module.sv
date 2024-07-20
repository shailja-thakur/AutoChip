module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    initial begin
        q = 8'h0; // Set the output to default value
    end

    always @(posedge clk) begin // Triggered on rising edge of clock
        q <= d; // Store data input in register
    end

endmodule
