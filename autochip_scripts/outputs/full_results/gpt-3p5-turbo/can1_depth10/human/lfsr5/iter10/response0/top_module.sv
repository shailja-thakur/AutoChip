module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] next_q;
    reg [3:0] taps;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            next_q <= 5'b1;
            taps <= 4'b0;
        end
        else begin
            taps[3:0] <= {q[4], q[2], 1'b0};
            next_q <= {q[3:0], q[4] ^ q[taps]};
        end
    end

    always @(posedge clk) begin
        if (reset)
            q <= 5'b1;
        else
            q <= next_q;
    end

endmodule
