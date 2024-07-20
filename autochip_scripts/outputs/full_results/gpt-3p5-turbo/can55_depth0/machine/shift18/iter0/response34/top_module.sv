module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= {q[62:0], 1'b0};
        end else if (ena) begin
            case (amount)
                2'h0: q <= {q[55:0], 8'b0};
                2'h1: q <= {q[63], q[63:1]};
                2'h2: q <= {8{q[63]}}, q[63:8]};
                2'h3: q <= 64'hx;
                default: q <= q;
            endcase
        end
    end
endmodule
