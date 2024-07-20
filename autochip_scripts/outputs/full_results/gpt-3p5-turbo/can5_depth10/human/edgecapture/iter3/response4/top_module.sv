module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;
    reg [31:0] next_in;
    
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            out <= 0;
            previous_in <= 0;
        end
        else begin
            next_in <= in;
            previous_in <= next_in;
            out <= out | (previous_in & ~next_in);
        end
    end

endmodule
