module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;  // State register with 3 bits to count up to 4 (0-3)

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;  // Reset state to 0
            shift_ena <= 1;   // Enable shift register
        end
        else if (state < 3'b100) begin
            state <= state + 1;  // Increment state
            if (state == 3'b011) begin
                shift_ena <= 0;  // Disable shift register after 4 cycles
            end
        end
    end
endmodule
