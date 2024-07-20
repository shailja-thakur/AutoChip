module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] count;
    reg shift_enable;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100; // Initialize count to 4
            shift_enable <= 1'b1; // Enable shift for first 4 cycles
        end else if (shift_enable) begin
            if (count == 3'b000) begin
                shift_enable <= 1'b0; // Disable shift after 4 cycles
            end else begin
                count <= count - 1;
            end
        end
    end

    assign shift_ena = shift_enable;

endmodule
