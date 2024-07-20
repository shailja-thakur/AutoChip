module top_module(
    input clk,
    input reset,
    output reg shift_ena);
    
    reg [2:0] cycle_counter;
    
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            cycle_counter <= 3'b100; // start with 4 cycles
        end else if (cycle_counter != 0) begin
            cycle_counter <= cycle_counter - 1;
            if (cycle_counter == 1)
                shift_ena <= 0;
        end else begin
            shift_ena <= 0;
        end
    end
endmodule
