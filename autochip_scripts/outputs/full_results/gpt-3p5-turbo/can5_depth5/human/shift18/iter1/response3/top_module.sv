module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    reg [7:0] shift_amount;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case(amount)
                2'b00: shift_amount <= 1;
                2'b01: shift_amount <= 8;
                2'b10: shift_amount <= -1;
                2'b11: shift_amount <= -8;
            endcase

            if (shift_amount > 0)
                q <= q << shift_amount;
            else if (shift_amount < 0)
                q <= q >>> -shift_amount;
        end
    end
endmodule
