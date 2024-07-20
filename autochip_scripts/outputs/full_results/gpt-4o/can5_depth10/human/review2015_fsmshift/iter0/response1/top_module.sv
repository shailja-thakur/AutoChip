module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 3'b100; // Initialize count to 4
        shift_ena <= 1'b1; // Enable shift_ena
    end else if (count > 0) begin
        count <= count - 1;
        shift_ena <= 1'b1; // Keep shift_ena asserted
    end else begin
        shift_ena <= 1'b0; // Deassert shift_ena
    end
end

endmodule
