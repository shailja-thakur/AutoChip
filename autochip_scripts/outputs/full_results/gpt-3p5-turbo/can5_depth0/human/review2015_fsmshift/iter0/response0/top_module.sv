module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [3:0] counter;
    reg shift_ena;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'b0000;
            shift_ena <= 1'b1;
        end else if (counter != 4'b0101) begin
            counter <= counter + 1;
            shift_ena <= 1'b1;
        end else begin
            counter <= 4'b0000;
            shift_ena <= 1'b0;
        end
    end
endmodule
