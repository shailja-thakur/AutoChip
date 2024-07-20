module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

// Internal signals
reg [63:0] shift_data;

always @(posedge clk) begin
    if (load) begin
        shift_data <= data;
    end else begin
        case (amount)
            2'b00: shift_data <= {shift_data[62:0], shift_data[63]};
            2'b01: shift_data <= {shift_data[55:0], shift_data[63:8]};
            2'b10: shift_data <= {shift_data[0], shift_data[63:1]};
            2'b11: shift_data <= {shift_data[7:0], shift_data[63:8]};
            default: shift_data <= shift_data;
        endcase
    end
    
    if (ena) begin
        q <= shift_data;
    end
end

endmodule
