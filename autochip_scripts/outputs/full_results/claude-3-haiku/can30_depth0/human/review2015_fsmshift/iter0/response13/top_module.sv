module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 2'b00;
        shift_ena <= 1'b1;
    end
    else if (count < 2'b11) begin
        count <= count + 1'b1;
        shift_ena <= 1'b1;
    end
    else begin
        count <= 2'b00;
        shift_ena <= 1'b0;
    end
end

endmodule
