module top_module(
    input x,
    input y,
    output z);
    
    reg z;

    always @(*) begin
        case({x, y})
            2'b00: z = 1; // Initial value of 1 for z
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase
    end

endmodule
