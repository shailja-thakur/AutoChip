module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;
    reg [511:0] next_q;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 512; i = i + 1) begin
                case (i)
                    0: next_q[i] = q[1]; // Left boundary, q[-1] is assumed 0
                    511: next_q[i] = q[510]; // Right boundary, q[512] is assumed 0
                    default: next_q[i] = q[i-1] ^ q[i+1];
                endcase
            end
            q <= next_q;
        end
    end

endmodule
