module top_module (
    input [3:0] in,
    output reg [1:0] pos
);
    
    always @(*) begin
        case(in)
            4'b0000: pos = 2'b00;
            4'b0001: pos = 2'b01;
            4'b0010: pos = 2'b10;
            default: pos = 2'b11;
        endcase
    end      
    
endmodule
