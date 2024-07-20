module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

always @(posedge clk) begin
    if (load) begin
        // Load the shift register with data
        q <= data;
    end
    else if (ena) begin
        case (amount)
            2'b00: // Shift left by 1 bit
                q <= {q[62:0], 1'b0};
            2'b01: // Shift left by 8 bits
                q <= {q[55:0], 8'b0};
            2'b10: // Shift right by 1 bit, arithmetic shift
                q <= {{1{q[63]}}, q[63:1]};
            2'b11: // Shift right by 8 bits, arithmetic shift
                q <= {{8{q[63]}}, q[63:8]};
        endcase
    end
end

endmodule
