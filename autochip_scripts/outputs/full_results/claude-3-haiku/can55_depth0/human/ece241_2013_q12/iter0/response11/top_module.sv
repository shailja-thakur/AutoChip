module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    // 8-bit shift register
    reg [7:0] Q;
    
    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S};
        end
    end
    
    // 3-to-8 decoder for selecting the appropriate bit from the shift register
    wire [7:0] decoder_output;
    assign decoder_output[0] = ~A & ~B & ~C;
    assign decoder_output[1] = ~A & ~B &  C;
    assign decoder_output[2] = ~A &  B & ~C;
    assign decoder_output[3] = ~A &  B &  C;
    assign decoder_output[4] =  A & ~B & ~C;
    assign decoder_output[5] =  A & ~B &  C;
    assign decoder_output[6] =  A &  B & ~C;
    assign decoder_output[7] =  A &  B &  C;
    
    // Assign the selected bit from the shift register to the output Z
    always @(*) begin
        Z = Q[0] & decoder_output[0]
          | Q[1] & decoder_output[1]
          | Q[2] & decoder_output[2]
          | Q[3] & decoder_output[3]
          | Q[4] & decoder_output[4]
          | Q[5] & decoder_output[5]
          | Q[6] & decoder_output[6]
          | Q[7] & decoder_output[7];
    end

endmodule
