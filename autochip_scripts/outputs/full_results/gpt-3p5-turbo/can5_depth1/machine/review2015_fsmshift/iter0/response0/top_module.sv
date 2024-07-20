module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);
    
    always @(posedge clk) begin
        if (reset == 1) begin
            state <= 3'b000;
        end else if ((state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) && shift_ena == 1) begin
            state <= state + 1;
        end else begin
            state <= 3'b100;
        end
    end
    
    assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) ? 1 : 0;
    
endmodule
