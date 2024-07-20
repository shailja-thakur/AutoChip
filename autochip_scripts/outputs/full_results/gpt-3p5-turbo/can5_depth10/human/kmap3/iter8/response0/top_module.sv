module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

reg out_temp;

always @(*)
begin
    case({a,b,c,d})
        4'b0000: out_temp = 1'b0; // Corrected output value to be 0
        4'b0001: out_temp = 1'b0; // Corrected output value to be 0
        4'b0010: out_temp = 1'b1; 
        4'b0011: out_temp = 1'b1; 
        4'b0100: out_temp = 1'b0;
        4'b0101: out_temp = 1'b0;
        4'b0110: out_temp = 1'b0;
        4'b0111: out_temp = 1'b1;  // Changed output value to be 1
        4'b1000: out_temp = 1'b1;
        4'b1001: out_temp = 1'b1;
        4'b1010: out_temp = 1'b1;
        4'b1011: out_temp = 1'b1;
        4'b1100: out_temp = 1'b1;
        4'b1101: out_temp = 1'b1;
        4'b1110: out_temp = 1'b1;
        default: out_temp = 1'bx; // Changed default output value to be don't-care
    endcase
end

always @(posedge c)
    out <= out_temp;

endmodule
