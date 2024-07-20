module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        shift_ena <= 1'b1;
        count <= 2'b00;
    end
    else begin
        if (count < CYCLES - 1) begin
            shift_ena <= 1'b1;
            count <= count + 1'b1;
        end
        else begin
            shift_ena <= 1'b0;
            count <= 2'b00;
        end
    end
end

endmodule
