module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    // Internal registers
    reg [31:0] in_prev;

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
        end else begin
            // Loop through each bit in the vector
            for (integer i = 0; i < 32; i = i + 1) begin
                // If the bit has changed from 1 to 0
                if (in[i] == 1 && in_prev[i] == 0) begin
                    out[i] <= 1;
                end
            end

            // Update previous input value
            in_prev <= in;
        end
    end

endmodule
