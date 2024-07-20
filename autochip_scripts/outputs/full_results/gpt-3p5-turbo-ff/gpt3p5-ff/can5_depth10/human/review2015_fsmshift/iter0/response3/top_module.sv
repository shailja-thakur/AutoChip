module top_module(
    input clk,
    input reset,
    output shift_ena);
    
    reg [3:0] shift_count;
    reg [3:0] shift_pattern;
    reg enable_shift;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 4'd0;
            enable_shift <= 1'b0;
        end
        else if (shift_count < 4'd4) begin
            shift_count <= shift_count + 1'b1;
            enable_shift <= (shift_pattern == 4'b1010);
        end
        else begin
            enable_shift <= 1'b0;
        end
    end

    // Shift Register Module

    // ... (rest of the module)

    assign shift_ena = enable_shift;
endmodule
