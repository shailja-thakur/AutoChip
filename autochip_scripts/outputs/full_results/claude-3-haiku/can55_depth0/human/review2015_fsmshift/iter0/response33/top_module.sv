module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_CYCLES = 4;

reg [1:0] cycle_count;

always @(posedge clk) begin
    if (reset) begin
        shift_ena <= 1'b1;
        cycle_count <= 2'b00;
    end
    else if (cycle_count < SHIFT_CYCLES-1) begin
        shift_ena <= 1'b1;
        cycle_count <= cycle_count + 1'b1;
    end
    else begin
        shift_ena <= 1'b0;
        cycle_count <= 2'b00;
    end
end

endmodule
