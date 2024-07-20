module top_module(
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= {q[62:0], 1'b0};
        end else if (ena) begin
            case (amount)
                2'b00: q <= {q[62:0], 8'b0};
                2'b01: q <= {q[54:0], 9'b0};
                2'b10: q <= {q[63], q[62:1]};
                2'b11: q <= {{8{q[63]}}, q[63:8]};
                default: q <= 64'hx;
            endcase
        end else begin
            q <= {q[62:0], 1'b0};
        end
    end
endmodule
