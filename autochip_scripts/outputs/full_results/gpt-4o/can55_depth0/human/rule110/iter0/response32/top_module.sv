module top_module (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;

            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Considering q[-1] = 0 and q[512] = 0
                    next_q[i] <= (0 << 2) | (q[0] << 1) | q[1];
                end else if (i == 511) begin
                    // Considering q[-1] = 0 and q[512] = 0
                    next_q[i] <= (q[510] << 2) | (q[511] << 1) | 0;
                end else begin
                    next_q[i] <= (q[i-1] << 2) | (q[i] << 1) | q[i+1];
                end
                
                // Applying Rule 110
                case (next_q[i])
                    3'b111: q[i] <= 0; // 7
                    3'b110: q[i] <= 1; // 6
                    3'b101: q[i] <= 1; // 5
                    3'b100: q[i] <= 0; // 4
                    3'b011: q[i] <= 1; // 3
                    3'b010: q[i] <= 1; // 2
                    3'b001: q[i] <= 1; // 1
                    3'b000: q[i] <= 0; // 0
                endcase
            end
        end
    end
endmodule
