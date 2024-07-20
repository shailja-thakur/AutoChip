module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [3:0] counter;
    reg enable_flag;

    always @(posedge clk) begin
        if (reset)
            counter <= 0;
        else if (counter == 4) begin
            counter <= 0;
            shift_ena <= 0;
        end
        else begin
            counter <= counter + 1;
            shift_ena <= enable_flag;
        end
    end

    always @(posedge clk) begin
        if (reset)
            enable_flag <= 1;
        else if (shift_ena)
            enable_flag <= 0;
    end

endmodule
