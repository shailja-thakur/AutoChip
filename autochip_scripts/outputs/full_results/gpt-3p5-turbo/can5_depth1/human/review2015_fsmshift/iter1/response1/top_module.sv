module top_module(
    input clk,
    input reset,
    output shift_ena
);

reg [3:0] counter;
reg shift_ena_temp;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 4'b1111;
        shift_ena_temp <= 1'b1;
    end else if (counter > 0) begin
        counter <= counter - 1;
        shift_ena_temp <= 1'b1;
    end else begin
        shift_ena_temp <= 1'b0;
    end
end

assign shift_ena = shift_ena_temp;

endmodule
