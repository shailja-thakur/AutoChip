module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    // Internal shift register
    reg [63:0] shift_reg;
    
    always @(posedge clk) begin
        if (load) begin
            // Load the shift register with data
            shift_reg <= data;
        end else if (ena) begin
            case (amount)
                2'b00: begin
                    // Shift left by 1 bit
                    shift_reg <= shift_reg << 1;
                end

                2'b01: begin
                    // Shift left by 8 bits
                    shift_reg <= shift_reg << 8;
                end

                2'b10: begin
                    // Shift right by 1 bit (arithmetic right shift)
                    shift_reg <= shift_reg >> 1;
                end

                2'b11: begin
                    // Shift right by 8 bits (arithmetic right shift)
                    shift_reg <= shift_reg >> 8;
                end
            endcase
        end
    end
    
    // Output the contents of the shift register
    assign q = shift_reg;
    
endmodule
