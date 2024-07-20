module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count; // 3-bit counter to count up to 4 cycles

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b000;
            shift_ena <= 1;
        end else if (shift_ena) begin
            if (count == 3'b011) begin
                shift_ena <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end

endmodule
