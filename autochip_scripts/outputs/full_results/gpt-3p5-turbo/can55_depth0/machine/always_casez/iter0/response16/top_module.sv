module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    
    always @(in) begin
        casez(in)
            8'bzzzzzzz1: pos <= 3'b0;
            8'bz1zzzzzz: pos <= 3'b6;
            // Define more cases here
            default: pos <= 3'b000;
        endcase
    end

endmodule
