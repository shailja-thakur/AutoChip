module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    reg [63:0] temp;

    always @(posedge clk) begin
        if (load) begin
            q <= {data[62:0], 1'b0};
        end else if (ena) begin
            case (amount)
                2'b00: begin
                    temp <= {q[62:0], q[63]};
                end

                2'b01: begin
                    temp <= {q[54:0], 8'b0};
                end

                2'b10: begin
                    temp <= {q[63], q[62:1]};
                end

                2'b11: begin
                    temp <= {64{q[63]}};
                end

                default: begin
                    temp <= 64'hx;
                end
            endcase
            q <= temp;
        end else begin
            q <= q;
        end
    end

endmodule
