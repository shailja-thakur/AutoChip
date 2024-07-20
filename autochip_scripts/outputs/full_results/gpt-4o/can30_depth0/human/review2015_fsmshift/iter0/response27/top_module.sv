module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] count; // 3-bit counter to count 4 clock cycles

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100; // Set count to 4 when reset is high
            shift_ena <= 1'b1;
        end else if (count > 0) begin
            count <= count - 1;
            if (count == 1)
                shift_ena <= 1'b0;
        end
    end

endmodule
