module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;

reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= CYCLES - 1;
        shift_ena <= 1'b1;
    end
    else if (count != 0) begin
        count <= count - 1;
        shift_ena <= 1'b1;
    end
    else begin
        shift_ena <= 1'b0;
    end
end

endmodule
