module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_state;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_state[i] = 1'b0 ^ q[i+1]; // Left neighbor is zero
                end else if (i == 511) begin
                    next_state[i] = q[i-1] ^ 1'b0; // Right neighbor is zero
                end else begin
                    next_state[i] = q[i-1] ^ q[i+1];
                end
            end
            q <= next_state;
        end
    end
    
endmodule
