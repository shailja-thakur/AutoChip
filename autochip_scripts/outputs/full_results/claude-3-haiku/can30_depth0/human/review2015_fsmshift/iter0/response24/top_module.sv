module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam WAIT_CYCLES = 4;

reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
        shift_ena <= 1'b1;
    end
    else if (count < WAIT_CYCLES) begin
        count <= count + 1;
        shift_ena <= 1'b1;
    end
    else begin
        shift_ena <= 1'b0;
    end
end

endmodule
