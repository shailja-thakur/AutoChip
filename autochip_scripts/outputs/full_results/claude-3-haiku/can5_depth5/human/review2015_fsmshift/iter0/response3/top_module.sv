module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;

reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
        shift_ena <= 1'b1;
    end
    else if (count < CYCLES - 1) begin
        count <= count + 1;
        shift_ena <= 1'b1;
    end
    else begin
        count <= 0;
        shift_ena <= 1'b0;
    end
end

endmodule
