module top_module(
    input clk,
    input reset,
    output shift_ena
);

reg [3:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 4'b1111;
    end else if (counter > 0) begin
        counter <= counter - 1;
    end
end

assign shift_ena = (counter > 0);

endmodule
