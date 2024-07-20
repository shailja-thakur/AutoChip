module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    reg [1023:0] in_reg;
    reg [7:0] sel_reg;
    wire [3:0] out_wire;
    
    always @ (in or sel) begin
        in_reg = in;
        sel_reg = sel;
        out_wire = in_reg[sel_reg+3:sel_reg];
    end
    
    assign out = out_wire;
    
endmodule
