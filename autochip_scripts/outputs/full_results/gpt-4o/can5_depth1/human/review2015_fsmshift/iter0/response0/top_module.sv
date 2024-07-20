module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b100; // Sets count to 4
            shift_ena <= 1;
        end else if (count > 0) begin
            count <= count - 1;
            if (count == 1) begin
                shift_ena <= 0;
            end
        end
    end

endmodule
