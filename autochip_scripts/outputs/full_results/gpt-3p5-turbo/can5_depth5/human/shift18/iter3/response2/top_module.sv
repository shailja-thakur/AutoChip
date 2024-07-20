module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    always @(*) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case(amount)
                2'b00: q <= q << 1;
                2'b01: q <= q << 8;
                2'b10: q <= q >>> 1; // Use unsigned right shift operator
                2'b11: q <= q >>> 8; // Use unsigned right shift operator
            endcase
        end
    end

endmodule
