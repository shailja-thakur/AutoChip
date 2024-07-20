module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam ASSERT_SHIFT_ENA = 4'd4; // Assert shift_ena for 4 cycles

reg [3:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= ASSERT_SHIFT_ENA;
        shift_ena <= 1'b1;
    end
    else if (count > 0) begin
        count <= count - 1'b1;
        shift_ena <= 1'b1;
    end
    else begin
        shift_ena <= 1'b0;
    end
end

endmodule
