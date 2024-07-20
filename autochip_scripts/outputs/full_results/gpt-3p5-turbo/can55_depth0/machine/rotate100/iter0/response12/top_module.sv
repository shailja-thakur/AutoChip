module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);
    reg [99:0] reg_data;
    reg [99:0] shift_data;

    always @(posedge clk) begin
        if (load == 1'b1) // Load data into output register
            reg_data <= data;
        
        case(ena)
            2'h1: shift_data <= {reg_data[98:0], 1'b0}; // Shift left
            2'h2: shift_data <= {1'b0, reg_data[99:1]}; // Shift right
            default: shift_data <= reg_data; // No shift
        endcase

        q <= shift_data;
    end
endmodule
