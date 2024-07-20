module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'd0;
            state <= 1'b1;
            shift_ena <= 1'b1;
        end else if (state) begin
            if (count == 3'd3) begin
                state <= 1'b0;
                shift_ena <= 1'b0;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule
