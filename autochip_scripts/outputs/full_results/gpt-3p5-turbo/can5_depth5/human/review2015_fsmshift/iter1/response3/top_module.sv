module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [3:0] count;

    always @(posedge clk) begin
        if (reset)
            count <= 4'b1111;
        else if (count > 0)
            count <= count - 1;
    end

    always @(count) begin
        if (reset)
            shift_ena <= 1'b1;
        else if (count == 4'b0101)
            shift_ena <= 1'b1;
        else
            shift_ena <= 1'b0;
    end

endmodule
