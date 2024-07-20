module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

    always @(*) begin
        case({a, b, c, d})
            // Conditions for logic-1
            2'b00_00, 7'b00_0000, 15'b00_0000_0000_0000_0: begin
                out_sop = 1'b1;
                out_pos = 1'b1;
            end
            
            // Conditions for logic-0
            4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110: begin
                out_sop = 1'b0;
                out_pos = 1'b0;
            end
            
            default: begin
                out_sop = 1'b0;
                out_pos = 1'b0;
            end
        endcase
    end
    
endmodule
