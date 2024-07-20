module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [3:0] enable_counter;
    reg shift_ena;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1;
            enable_counter <= 4'b1111;
        end else if (enable_counter > 0) begin
            shift_ena <= 1;
            enable_counter <= enable_counter - 1;
        end else begin
            shift_ena <= 0;
        end
    end

endmodule
