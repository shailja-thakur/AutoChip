module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_state;

    always @(*) begin
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                next_state[i] = (q[i+1] == 1'b1 && q[i] == 1'b1 && 1'b0) ||
                                (q[i+1] == 1'b0 && q[i] == 1'b1 && 1'b1) ||
                                (q[i+1] == 1'b1 && q[i] == 1'b0 && 1'b1) ||
                                (q[i+1] == 1'b0 && q[i] == 1'b0 && 1'b0);
            end
            else if (i == 511) begin
                next_state[i] = (1'b0 && q[i] == 1'b1 && 1'b0) ||
                                (1'b0 && q[i] == 1'b0 && 1'b1) ||
                                (q[i-1] == 1'b1 && q[i] == 1'b0 && 1'b1) ||
                                (q[i-1] == 1'b0 && q[i] == 1'b0 && 1'b0);
            end
            else begin
                next_state[i] = (q[i-1] == 1'b1 && q[i] == 1'b1 && q[i+1] == 1'b0) ||
                                (q[i-1] == 1'b0 && q[i] == 1'b1 && q[i+1] == 1'b1) ||
                                (q[i-1] == 1'b0 && q[i] == 1'b0 && q[i+1] == 1'b1) ||
                                (q[i-1] == 1'b1 && q[i] == 1'b0 && q[i+1] == 1'b1);
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= next_state;
        end
    end

endmodule
