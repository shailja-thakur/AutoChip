module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 3'b100; // Initialize to count 4 cycles
            shift_ena <= 1'b1;     // Enable shifting for 4 cycles
        end
        else begin
            if (cycle_count > 0) begin
                cycle_count <= cycle_count - 1;
                shift_ena <= 1'b1;
            end
            else begin
                shift_ena <= 1'b0;
            end
        end
    end

endmodule
