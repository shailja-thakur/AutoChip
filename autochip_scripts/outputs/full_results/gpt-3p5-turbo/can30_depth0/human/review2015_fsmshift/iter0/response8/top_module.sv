module top_module(
    input clk,
    input reset,
    output shift_ena);
    
    reg [3:0] counter;
    reg shift_ena;
    reg shift_ena_next;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            shift_ena <= 1;
        end else begin
            counter <= counter + 1;
            shift_ena <= shift_ena_next;
        end
    end
    
    always @(*) begin
        if (counter >= 4) begin
            shift_ena_next = 0;
        end else begin
            shift_ena_next = 1;
        end
    end
    
endmodule
