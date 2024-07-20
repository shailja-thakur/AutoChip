module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset == 1) begin
            state <= 3'b000;
            shift_ena <= 1;
        end else if (state == 3'b000) begin
            state <= 3'b001;
            shift_ena <= 1;
        end else if (state == 3'b001) begin
            state <= 3'b010;
            shift_ena <= 1;
        end else if (state == 3'b010) begin
            state <= 3'b011;
            shift_ena <= 1;
        end else if (state == 3'b011) begin
            state <= 3'b100;
            shift_ena <= 1;
        end else begin
            state <= 3'b100;
            shift_ena <= 0;
        end
    end

endmodule
