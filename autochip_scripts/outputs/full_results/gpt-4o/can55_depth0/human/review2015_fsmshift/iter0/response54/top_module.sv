module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;  // 3-bit counter to count up to 4

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'd0;
            shift_ena <= 1'b1;
        end else if (shift_ena) begin
            if (count < 3'd3) begin
                count <= count + 3'd1;
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end
endmodule
