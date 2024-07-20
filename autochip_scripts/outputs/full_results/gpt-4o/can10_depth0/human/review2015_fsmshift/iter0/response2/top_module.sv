module top_module(
    input clk,
    input reset,
    output reg shift_ena);
    
    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100;  // Preset to 4 (100 in binary)
            shift_ena <= 1'b1;
        end else if (count != 3'b000) begin
            count <= count - 1'b1;
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end
endmodule
