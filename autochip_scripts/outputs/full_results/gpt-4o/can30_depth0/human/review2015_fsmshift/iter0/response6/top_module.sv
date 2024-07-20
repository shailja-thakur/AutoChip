module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 3'b100;
            shift_ena <= 1'b1;
        end
        else if (counter > 0) begin
            counter <= counter - 1;
            if(counter == 1) 
                shift_ena <= 1'b0;
        end
    end
endmodule
