module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Compute the next state of the cellular automaton
            for (int i = 0; i < 512; i++) begin
                int left = (i == 0) ? 0 : q[i-1];
                int center = q[i];
                int right = (i == 511) ? 0 : q[i+1];
                
                case ({left, center, right})
                    3'b111: q[i] <= 1'b0;
                    3'b110: q[i] <= 1'b1;
                    3'b101: q[i] <= 1'b1;
                    3'b100: q[i] <= 1'b0;
                    3'b011: q[i] <= 1'b1;
                    3'b010: q[i] <= 1'b1;
                    3'b001: q[i] <= 1'b1;
                    3'b000: q[i] <= 1'b0;
                endcase
            end
        end
    end

endmodule
