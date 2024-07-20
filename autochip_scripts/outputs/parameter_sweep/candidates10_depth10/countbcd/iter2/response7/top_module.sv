module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

reg [3:0] digit;

always @(posedge clk) begin
    if(reset) begin
        q <= 16'd0;
        digit <= 4'd0;
        ena <= 3'b0;
    end else begin
        if (q[3:0] == 4'd9) begin
            digit <= 4'd1;
            ena <= {2'b0, 1'b1};
        end else if (q[7:4] == 4'd9) begin
            digit <= 4'd2;
            ena <= {1'b0, 1'b1, 1'b0};
        end else if (q[11:8] == 4'd9) begin
            digit <= 4'd3;
            ena <= {1'b0, 2'b0, 1'b1};
        end else begin
            digit <= 4'd0;
            ena <= 3'b0;
        end

        if (q == 16'd9999) begin
            q <= 16'd0;
        end else begin
            q <= q + 1;
        end

        case(digit)
            4'd1: q[3:0] <= q[3:0] + 1;
            4'd2: q[7:4] <= q[7:4] + 1;
            4'd3: q[11:8] <= q[11:8] + 1;
        end
    end
end

endmodule
