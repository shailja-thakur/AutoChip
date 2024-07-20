module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

// Register for storing data
reg [63:0] shift_reg;

// Synchronous load operation
always @(posedge clk) begin
    if (load) begin
        shift_reg <= data;
    end else if (ena) begin
        // Shift operation based on the selected amount
        case (amount)
            2'b00: shift_reg <= {shift_reg[62:0], shift_reg[63]};
            2'b01: shift_reg <= {shift_reg[55:0], shift_reg[63:8]};
            2'b10: shift_reg <= {shift_reg[0], shift_reg[63:1]};
            2'b11: shift_reg <= {shift_reg[7:0], shift_reg[63:8]};
            default: shift_reg <= shift_reg;
        endcase
    end else begin
        shift_reg <= shift_reg;
    end
end

// Assign the output
assign q = shift_reg;

endmodule
