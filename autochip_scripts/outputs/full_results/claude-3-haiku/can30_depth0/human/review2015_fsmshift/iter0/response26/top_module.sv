module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 2'b00;
        shift_ena <= 1'b1;
    end
    else begin
        if (count == 2'b11) begin
            shift_ena <= 1'b0;
        end
        else begin
            shift_ena <= 1'b1;
            count <= count + 1'b1;
        end
    end
end

endmodule
