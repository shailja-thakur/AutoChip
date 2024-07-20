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
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: // shift left by 1 bit
                    q <= {q[62:0], q[63]};
                2'b01: // shift left by 8 bits
                    q <= {q[55:0], q[63:56]};
                2'b10: // shift right by 1 bit
                    q <= {q[0], q[63:1]};
                2'b11: // shift right by 8 bits
                    q <= {q[7:0], q[63:8]};
            endcase
        end
    end
endmodule
