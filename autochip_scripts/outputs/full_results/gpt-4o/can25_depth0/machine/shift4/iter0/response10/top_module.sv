module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
    );

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000;  // Asynchronous reset
        end 
        else if (load) begin
            q <= data;     // Load data input into output register
        end 
        else if (ena) begin
            q <= q << 1;   // Shift the register left by 1 bit
        end
        // If none of the signals are active, output register remains unchanged
    end

endmodule
