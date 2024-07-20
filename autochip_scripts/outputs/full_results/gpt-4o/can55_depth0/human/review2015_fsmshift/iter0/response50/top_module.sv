module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] cycle_counter;

    always @(posedge clk) begin
        if (reset) begin
            cycle_counter <= 3'b100; // Enable for 4 cycles
            shift_ena <= 1;
        end else begin
            if (cycle_counter > 0) begin
                cycle_counter <= cycle_counter - 1;
                shift_ena <= 1;
            end else begin
                shift_ena <= 0;
            end
        end
    end
endmodule
