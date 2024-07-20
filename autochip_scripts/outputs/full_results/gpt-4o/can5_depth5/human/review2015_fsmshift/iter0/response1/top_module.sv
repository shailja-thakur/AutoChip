module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100;
            shift_ena <= 1'b1;
        end else if (count > 0) begin
            count <= count - 1;
            shift_ena <= (count > 1) ? 1'b1 : 1'b0;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
