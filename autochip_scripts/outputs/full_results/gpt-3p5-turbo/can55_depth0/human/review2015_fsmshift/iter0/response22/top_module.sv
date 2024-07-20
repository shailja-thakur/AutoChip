module top_module(
    input clk,
    input reset,
    output reg shift_ena);
    
    reg [3:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            state <= 0;
        end else if (state == 4'b0000 && shift_ena) begin
            shift_ena <= 0;
            state <= 4'b0001;
        end else if (state == 4'b0001) begin
            state <= 4'b0010;
        end else if (state == 4'b0010) begin
            state <= 4'b0011;
        end else if (state == 4'b0011) begin
            state <= 4'b0000;
        end
    end
    
endmodule
