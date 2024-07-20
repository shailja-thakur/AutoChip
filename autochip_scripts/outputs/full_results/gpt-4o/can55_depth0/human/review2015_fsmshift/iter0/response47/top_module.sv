module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100; // Load count with 4 on reset
            shift_ena <= 1'b1; // Enable shift for the first clock cycle
        end
        else if (count > 0) begin
            count <= count - 1'b1; // Decrement count
            shift_ena <= 1'b1; // Keep shift enabled while count is not zero
        end
        else begin
            shift_ena <= 1'b0; // Disable shift once count reaches zero
        end
    end
endmodule
