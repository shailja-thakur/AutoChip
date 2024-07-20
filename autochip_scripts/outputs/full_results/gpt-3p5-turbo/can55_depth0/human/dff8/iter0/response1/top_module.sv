module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);    

    reg [7:0] dff_q;
    
    always @(posedge clk) begin
        dff_q <= d;
    end
    
    assign q = dff_q;
    
endmodule
