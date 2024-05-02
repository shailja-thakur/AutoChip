module top_module( 
    input [31:0] in,
    output [31:0] out );

    //Insert your code here
    // assign out[31:24] = ...;

    always @(posedge clk) begin
        out <= in[23:16] | (in[15:8] << 8) | (in[7:0] << 16) | in[31:24];
    end

endmodule