module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            cycle_count <= 3'd4;
        end else if (cycle_count > 0) begin
            cycle_count <= cycle_count - 1;
            shift_ena <= 1;
        end else begin
            shift_ena <= 0;
        end
    end

endmodule
