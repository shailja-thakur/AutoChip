module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    wire [3:0] ones, tens, hundreds, thousands;
    assign ones = q[3:0];
    assign tens = q[7:4];
    assign hundreds = q[11:8];
    assign thousands = q[15:12];

    assign ena[1] = (ones == 4'd9);
    assign ena[2] = (ena[1] && (tens == 4'd9));
    assign ena[3] = (ena[2] && (hundreds == 4'd9));

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            if (ones == 4'd9) begin
                q[3:0] <= 4'd0;
                if (tens == 4'd9) begin
                    q[7:4] <= 4'd0;
                    if (hundreds == 4'd9) begin
                        q[11:8] <= 4'd0;
                        if (thousands == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end else begin
                            q[15:12] <= q[15:12] + 4'd1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 4'd1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                end
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
        end
    end
    
endmodule
