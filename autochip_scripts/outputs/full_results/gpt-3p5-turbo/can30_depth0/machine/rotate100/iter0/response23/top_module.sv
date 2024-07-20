module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    reg [99:0] q_next;

    always @(posedge clk) begin
        if (load) begin
            q_next <= data;
        end else begin
            case (ena)
                2'b01: q_next <= {q[98:0], 1'b0};
                2'b10: q_next <= {1'b0, q[99:1]};
                default: q_next <= q;
            endcase
        end
    end

    always @(posedge clk) begin
        q <= q_next;
    end

endmodule
