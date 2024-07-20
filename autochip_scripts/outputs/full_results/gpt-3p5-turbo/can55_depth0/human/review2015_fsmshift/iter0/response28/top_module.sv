module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [3:0] count; // Counter to count the number of clock cycles

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0000; // Reset the counter
        shift_ena <= 1'b1; // Enable the shift register
    end else if (count < 4'b0100) begin
        count <= count + 1; // Increment the counter
        shift_ena <= 1'b1; // Enable the shift register
    end else begin
        count <= 4'b0000; // Reset the counter
        shift_ena <= 1'b0; // Disable the shift register
    end
end

endmodule
