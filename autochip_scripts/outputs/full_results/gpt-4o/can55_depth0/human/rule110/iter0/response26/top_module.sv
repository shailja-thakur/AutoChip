module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    reg [512:0] temp_q; // Include boundaries
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            temp_q = {1'b0, q, 1'b0}; // Append 0's at boundary
            for (integer i = 0; i < 512; i = i + 1) begin
                case ({temp_q[i+2], temp_q[i+1], temp_q[i]})
                    3'b111: q[i] <= 1'b0;
                    3'b110: q[i] <= 1'b1;
                    3'b101: q[i] <= 1'b1;
                    3'b100: q[i] <= 1'b0;
                    3'b011: q[i] <= 1'b1;
                    3'b010: q[i] <= 1'b1;
                    3'b001: q[i] <= 1'b1;
                    3'b000: q[i] <= 1'b0;
                    default: q[i] <= 1'b0;
                endcase
            end
        end
    end
    
endmodule
