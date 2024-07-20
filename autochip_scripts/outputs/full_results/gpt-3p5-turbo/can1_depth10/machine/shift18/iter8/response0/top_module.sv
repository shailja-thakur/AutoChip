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
        q <= {q[62:0], 1'b0};
    end else if (ena) begin
        case (amount)
            2'b00: q <= {q[62:0], 1'b0};
            2'b01: q <= {q[55:0], 8'b0};
            2'b10: q <= {q[62:1], q[63]};
            2'b11: q <= {q[63:8], {8{q[63]}}};
            default: q <= 64'hx;
        endcase
    end else begin
        q <= q;
    end
end

endmodule
