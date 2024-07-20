module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] reg_out;
    
    always @(posedge clk) begin
        if (reset) begin
            reg_out <= 0;
        end else begin
            reg_out <= in;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
        end else begin
            out <= in & ~reg_out;
        end
    end
    
endmodule
