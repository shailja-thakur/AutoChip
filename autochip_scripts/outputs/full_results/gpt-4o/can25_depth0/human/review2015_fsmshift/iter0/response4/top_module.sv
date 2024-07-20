module top_module(
    input clk,
    input reset,
    output reg shift_ena 
);
    reg [2:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b1;
            counter <= 3'd4;
        end else if (counter != 3'd0) begin
            shift_ena <= 1'b1;
            counter <= counter - 1;
        end else begin
            shift_ena <= 1'b0;
        end
    end
endmodule
