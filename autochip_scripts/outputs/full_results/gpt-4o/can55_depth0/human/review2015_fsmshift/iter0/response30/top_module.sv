module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100;     // Counter for 4 cycles (3-bits to count 0 to 4)
            shift_ena <= 1'b1;   // Enable the shift register
        end else if (count > 0) begin
            count <= count - 1;
            if (count == 1) begin
                shift_ena <= 1'b0;  // Disable shift register after 4 cycles
            end
        end
    end

endmodule
