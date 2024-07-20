module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [3:0] temp_out;
    
    always @(*) begin
        case(sel)
            8'h00: temp_out = in[3:0];
            8'h01: temp_out = in[7:4];
            8'h02: temp_out = in[11:8];
            // add more cases for other values of sel
            default: temp_out = 4'bzzzz; // or any default value
        endcase
    end
    
    assign out = temp_out;
    
endmodule
