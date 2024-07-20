module top_module (
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] out_reg; // Declare a register to store the rearranged bits
    
    always @(*) begin
        out_reg[7:0] = in[31:24]; // Assign the first 8 bits of the input to the first 8 bits of the output_reg
        out_reg[15:8] = in[23:16]; // Assign the next 8 bits of the input to the next 8 bits of the output_reg
        out_reg[23:16] = in[15:8]; // Assign the next 8 bits of the input to the next 8 bits of the output_reg
        out_reg[31:24] = in[7:0]; // Assign the last 8 bits of the input to the last 8 bits of the output_reg
    end

    assign out = out_reg; // Assign the value of out_reg to the output

endmodule
