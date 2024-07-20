module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (shift_ena) begin
            shift_reg[3:1] <= shift_reg[2:0];
            shift_reg[0] <= data;
        end
        
        if (count_ena) begin
            if (shift_ena & count_ena) begin
                // do nothing
            end else if (shift_ena) begin
                shift_reg <= shift_reg - 1;
            end else if (count_ena) begin
                shift_reg <= shift_reg - 1;
            end
        end
    end
    
    assign q = shift_reg;
    
endmodule
