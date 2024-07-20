module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    always @(posedge clk)
    begin
        if (load)
        begin
            // Item 00
            q <= {q[62:0], 1'b0};
        end
        else if (ena)
        begin
            case (amount)
                2'b00:
                begin
                    // Item 01
                    q <= {q[55:0], 8'b0};
                end
                2'b01:
                begin
                    // Item 10
                    q <= {q[63], q[63:1]};
                end
                2'b10:
                begin
                    // Item 11
                    q <= {{8{q[63]}}, q[63:8]};
                end
                default:
                begin
                    // Default item
                    q <= 64'hx;
                end
            endcase
        end
    end

endmodule
