module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            count <= 0;
        end
        else if (shift_ena) begin
            if (count < 3) begin
                count <= count + 1;
            end
            else begin
                shift_ena <= 0;
            end
        end
    end

endmodule
