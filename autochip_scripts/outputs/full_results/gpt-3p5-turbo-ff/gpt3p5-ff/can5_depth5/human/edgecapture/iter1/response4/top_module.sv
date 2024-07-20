module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    reg [31:0] temp_out; // Temporary output to capture changes
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
            prev_in <= 0;
        end else begin
            prev_in <= in;
            temp_out = (prev_in & ~in);
            out <= out | temp_out;
            if (reset) begin
                out <= out & ~temp_out; // Reset the captured bits
            end
        end
    end

endmodule
