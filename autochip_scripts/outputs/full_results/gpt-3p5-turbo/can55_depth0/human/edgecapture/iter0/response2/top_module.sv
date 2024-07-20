module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
        
    // Create a register to capture the input signal
    reg [31:0] capture_reg;
        
    always @(posedge clk or posedge reset) begin
        // Reset the capture register when reset is active high
        if (reset)
            capture_reg <= 0;
        else begin
            // Update the capture register whenever the input signal changes
            if (in != capture_reg)
                capture_reg <= in;
        end
    end
        
    always @(posedge clk or posedge reset) begin
        // Reset the output register when reset is active high
        if (reset)
            out <= 0;
        else begin
            // Update the output register based on the captured values
            for (int i = 0; i < 32; i = i+1) begin
                // Update the output bit only when the input changes from 1 to 0
                if (in[i] & ~capture_reg[i])
                    out[i] <= 1;
            end
        end
    end
        
endmodule
