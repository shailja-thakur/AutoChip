module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);
    
    // Initialize q to 0
    initial begin
        q = 8'h00;
    end

    // Trigger on rising edge of clock
    always @(posedge clk) begin
        q <= d;
    end

endmodule
