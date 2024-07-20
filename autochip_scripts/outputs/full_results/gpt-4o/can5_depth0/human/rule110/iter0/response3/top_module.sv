module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q; // To store the next state

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                // Establish neighbour states, considering the boundaries as zero (off)
                reg left = (i == 0) ? 1'b0 : q[i-1];
                reg center = q[i];
                reg right = (i == 511) ? 1'b0 : q[i+1];
                
                // Determine the next state of the center cell
                case ({left, center, right})
                    3'b111: next_q[i] = 1'b0;
                    3'b110: next_q[i] = 1'b1;
                    3'b101: next_q[i] = 1'b1;
                    3'b100: next_q[i] = 1'b0;
                    3'b011: next_q[i] = 1'b1;
                    3'b010: next_q[i] = 1'b1;
                    3'b001: next_q[i] = 1'b1;
                    3'b000: next_q[i] = 1'b0;
                    default: next_q[i] = 1'b0; // default case, though unreachable
                endcase
            end
            q <= next_q;
        end
    end
endmodule
