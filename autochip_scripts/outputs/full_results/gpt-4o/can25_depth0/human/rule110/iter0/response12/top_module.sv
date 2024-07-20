module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(*) begin
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            // Boundary conditions with zero neighbors
            if (i == 0) begin
                next_q[i] = (q[0] == 0 && q[1] == 1) ? 1 : 0;
            end else if (i == 511) begin
                next_q[i] = (q[510] == 1 || q[511] == 1) ? 1 : 0;
            end else begin
                // Apply Rule 110
                case ({q[i-1], q[i], q[i+1]})
                    3'b111: next_q[i] = 0;
                    3'b110: next_q[i] = 1;
                    3'b101: next_q[i] = 1;
                    3'b100: next_q[i] = 0;
                    3'b011: next_q[i] = 1;
                    3'b010: next_q[i] = 1;
                    3'b001: next_q[i] = 1;
                    3'b000: next_q[i] = 0;
                endcase
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
