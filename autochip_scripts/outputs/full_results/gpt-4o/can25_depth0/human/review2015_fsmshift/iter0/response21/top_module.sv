module top_module(
    input clk,
    input reset,
    output shift_ena
);

reg [2:0] count;
reg shift_ena_reg;

assign shift_ena = shift_ena_reg;

always @(posedge clk) begin
    if (reset) begin
        count <= 3'b100;
        shift_ena_reg <= 1;
    end else if (count != 3'b000) begin
        count <= count - 1;
        shift_ena_reg <= 1;
    end else begin
        shift_ena_reg <= 0;
    end
end

endmodule
