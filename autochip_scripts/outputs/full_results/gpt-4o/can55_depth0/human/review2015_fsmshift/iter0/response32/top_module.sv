module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            count <= 3'd4;
        end
        else if (count != 0) begin
            shift_ena <= 1;
            count <= count - 1;
        end
        else begin
            shift_ena <= 0;
        end
    end
endmodule
