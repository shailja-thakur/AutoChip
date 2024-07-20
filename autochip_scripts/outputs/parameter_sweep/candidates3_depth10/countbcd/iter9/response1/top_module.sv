module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

    reg [3:0] q_temp;

    always @(posedge clk) begin
        if (reset) begin
            q_temp <= 0;
            ena <= 0;
        end else begin
            if (q_temp >= 9) begin
                q_temp <= 0;
                ena <= ena << 1;
            end else begin
                q_temp <= q_temp + 1;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= {q_temp+4'b001, q[15:4]};
        end
    end

endmodule
