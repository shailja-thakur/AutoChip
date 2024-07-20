module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            integer i;
            reg [511:0] next_state;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_state[i] = q[1]; // boundary condition: q[-1] is 0
                end
                else if (i == 511) begin
                    next_state[i] = q[510]; // boundary condition: q[512] is 0
                end
                else begin
                    next_state[i] = q[i-1] ^ q[i+1];
                end
            end
            q <= next_state;
        end
    end

endmodule
