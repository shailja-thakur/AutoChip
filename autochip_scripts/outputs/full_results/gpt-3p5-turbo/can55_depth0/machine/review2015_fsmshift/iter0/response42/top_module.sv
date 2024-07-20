module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else if (state == 3'b00) begin
            state <= 3'b01;
        end else if (state == 3'b01) begin
            state <= 3'b10;
        end else if (state == 3'b10) begin
            state <= 3'b11;
        end else if (state == 3'b11) begin
            state <= 3'b100;
        end else begin
            state <= 3'b100;
        end
    end

    assign shift_ena = (state != 3'b000);

endmodule
