module top_module(
    input clk,
    input reset,
    output shift_ena
);
    reg [2:0] count;
    reg shift;

    assign shift_ena = shift;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'd4;
            shift <= 1'b1;
        end
        else if (count > 0) begin
            count <= count - 1;
            if (count == 1)
                shift <= 1'b0;
        end
    end
endmodule
