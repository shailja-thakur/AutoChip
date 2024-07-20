module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 2'd0;
        shift_ena <= 1'b1;
    end
    else if (count < 2'd3) begin
        count <= count + 2'd1;
        shift_ena <= 1'b1;
    end
    else begin
        shift_ena <= 1'b0;
    end
end

endmodule
