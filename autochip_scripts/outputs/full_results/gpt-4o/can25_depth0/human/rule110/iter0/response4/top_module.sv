module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate next state of each cell
            next_q[0] = 0 ^ q[0];  // special case for left boundary (assume q[-1] = 0)
            next_q[511] = 0 ^ q[511];  // special case for right boundary (assume q[512] = 0)

            // General case for cells [1:510]
            for (int i = 1; i < 511; i = i + 1) begin
                case ({q[i+1], q[i], q[i-1]})
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
            
            q <= next_q;
        end
    end
endmodule
