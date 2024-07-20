module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    
    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in;                      // Store current input in d_last
        pedge <= in & ~d_last;             // Calculate the rising edge
    end

endmodule
