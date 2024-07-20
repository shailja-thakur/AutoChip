module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 2'd0;
        shift_ena <= 1'b1;
    end
    else if (counter < 2'd3) begin
        counter <= counter + 1'b1;
        shift_ena <= 1'b1;
    end
    else begin
        counter <= 2'd0;
        shift_ena <= 1'b0;
    end
end

endmodule
