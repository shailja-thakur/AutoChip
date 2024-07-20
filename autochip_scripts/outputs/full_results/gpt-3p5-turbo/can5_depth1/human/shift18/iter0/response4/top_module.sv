module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);
   
   // Define internal wire for 8-bit shift
   wire [7:0] shift_right_8bit;
   
   // Define internal reg to hold shifted value
   reg [63:0] shifted_value;
   
   always @(posedge clk) begin
       if (load) begin
           // Load the shift register with data
           q <= data;
       end else if (ena) begin
           // Determine the shift amount
           case (amount)
               2'b00: shift_right_8bit = 1; // Shift left by 1 bit
               2'b01: shift_right_8bit = 8; // Shift left by 8 bits
               2'b10: shift_right_8bit = -1; // Shift right by 1 bit (arithmetic right shift)
               2'b11: shift_right_8bit = -8; // Shift right by 8 bits (arithmetic right shift)
               default: shift_right_8bit = 1; // Default to shift left by 1 bit
           endcase
           
           // Perform the shift operation using a bitwise shift operator
           shifted_value = q >> shift_right_8bit;
           
           // Update the shift register with the shifted value
           q <= shifted_value;
       end
   end
   
endmodule
