module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);
    
    reg [99:0] shift_reg;
    
    always @(posedge clk) begin
        if (load) 
            shift_reg <= data;
        else begin
            if (ena == 2'b01) // Rotate right by one bit
                shift_reg <= {shift_reg[0], shift_reg[99:1]};
            else if (ena == 2'b10) // Rotate left by one bit
                shift_reg <= {shift_reg[98:0], shift_reg[99]};
            else
                shift_reg <= shift_reg; // No rotation
        end
    end
    
    assign q = shift_reg;
    
endmodule
