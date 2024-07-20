module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    reg [2:0] count;   // Counter to track the 4 clock cycles

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100; // Set count to 4 when reset is activated
            shift_ena <= 1;  // Enable shift_ena when reset is high
        end else if (count > 0) begin
            count <= count - 1; // Decrement count
            if (count == 1) begin
                shift_ena <= 0;  // Disable shift_ena after 4 cycles
            end
        end else begin
            shift_ena <= 0; // Ensure shift_ena stays 0 after 4 cycles
        end
    end
endmodule
