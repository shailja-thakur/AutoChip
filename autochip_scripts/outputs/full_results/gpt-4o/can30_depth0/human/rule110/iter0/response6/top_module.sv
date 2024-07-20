module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @* begin
        next_q = 512'b0;
        // Boundaries assume 0 (off)
        next_q[0] = (q[1] == 1'b1) ? 1'b1 : 1'b0;
        next_q[511] = (q[510] == 1'b1) ? 1'b1 : 1'b0;

        for (int i = 1; i < 511; i = i + 1) begin
            if (q[i-1] == 1'b1 && q[i] == 1'b1 && q[i+1] == 1'b1) next_q[i] = 1'b0;
            else if (q[i-1] == 1'b1 && q[i] == 1'b1 && q[i+1] == 1'b0) next_q[i] = 1'b1;
            else if (q[i-1] == 1'b1 && q[i] == 1'b0 && q[i+1] == 1'b1) next_q[i] = 1'b1;
            else if (q[i-1] == 1'b1 && q[i] == 1'b0 && q[i+1] == 1'b0) next_q[i] = 1'b0;
            else if (q[i-1] == 1'b0 && q[i] == 1'b1 && q[i+1] == 1'b1) next_q[i] = 1'b1;
            else if (q[i-1] == 1'b0 && q[i] == 1'b1 && q[i+1] == 1'b0) next_q[i] = 1'b1;
            else if (q[i-1] == 1'b0 && q[i] == 1'b0 && q[i+1] == 1'b1) next_q[i] = 1'b1;
            else next_q[i] = 1'b0;
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= next_q;
        end
    end

endmodule
