module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count; // 3-bit counter to count up to 4

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b0;  // Reset count
            shift_ena <= 1'b1; // Enable shift_ena
        end 
        else begin
            if (count < 3'b100) begin  // count is less than 4
                count <= count + 1'b1; // Increment count
                shift_ena <= 1'b1; // Enable shift_ena
            end 
            else begin
                shift_ena <= 1'b0; // Disable shift_ena
            end
        end
    end
endmodule
