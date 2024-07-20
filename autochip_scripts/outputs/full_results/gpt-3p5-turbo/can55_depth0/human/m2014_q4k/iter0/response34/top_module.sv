module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] shift_reg;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            shift_reg <= 4'b0;
        else
            shift_reg <= {shift_reg[2:0], in};
    end
    
    assign out = shift_reg[3];

endmodule
