module top_module(
    input clk,
    input reset,
    output shift_ena
);

reg [2:0] counter;
reg [3:0] shift_flag;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 3'b111;
        shift_flag <= 0;
    end else begin
        if (shift_flag == 4'b1010) begin
            counter <= 3'b111; // Reset counter for 4 clock cycles
            shift_flag <= 0; // Reset shift flag
        end else if (counter > 0) begin
            counter <= counter - 1;
            shift_flag <= {shift_flag[2:0], counter[0]}; // Shift the counter bits
        end
    end
end

assign shift_ena = (shift_flag == 4'b1010);

endmodule
