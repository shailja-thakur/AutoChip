module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);

reg [7:0] shift_register;
wire [2:0] addr;

// Shift register logic
always @(posedge clk) begin
    if (enable) begin
        shift_register <= {shift_register[6:0], S};
    end
end

// Address logic
always @(A or B or C) begin
    case ({A, B, C})
        3'b000: addr <= 3'b000;  // Select bit 0
        3'b001: addr <= 3'b001;  // Select bit 1
        3'b010: addr <= 3'b010;  // Select bit 2
        3'b011: addr <= 3'b011;  // Select bit 3
        3'b100: addr <= 3'b100;  // Select bit 4
        3'b101: addr <= 3'b101;  // Select bit 5
        3'b110: addr <= 3'b110;  // Select bit 6
        3'b111: addr <= 3'b111;  // Select bit 7
        default: addr <= 3'b000;  // Default to bit 0
    endcase
end

// Output MUX logic
always @(addr or shift_register) begin
    case (addr)
        3'b000: Z <= shift_register[0];
        3'b001: Z <= shift_register[1];
        3'b010: Z <= shift_register[2];
        3'b011: Z <= shift_register[3];
        3'b100: Z <= shift_register[4];
        3'b101: Z <= shift_register[5];
        3'b110: Z <= shift_register[6];
        3'b111: Z <= shift_register[7];
        default: Z <= shift_register[0];
    endcase
end

endmodule
