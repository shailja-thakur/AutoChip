module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg Y1_reg, Y3_reg;

always @(*) begin
    // Derive the Verilog for Y1 and Y3 by inspection assuming a one-hot encoding
    
    // Y1 is the input of state flip-flop y[1]
    case (y)
        6'b000001: Y1_reg = w;   // State A
        6'b000010: Y1_reg = ~w;  // State B
        6'b001000: Y1_reg = ~w;  // State D
        default: Y1_reg = 1'b0;
    endcase
    
    // Y3 is the input of state flip-flop y[3]
    case (y)
        6'b000010: Y3_reg = w;   // State B
        6'b000100: Y3_reg = ~w;  // State C
        6'b001000: Y3_reg = w;   // State D
        6'b100000: Y3_reg = ~w;  // State F
        default: Y3_reg = 1'b0;
    endcase
end

assign Y1 = Y1_reg;
assign Y3 = Y3_reg;

endmodule
