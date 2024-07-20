module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    reg [512:0] q_extended;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q_extended[511:0] = q;
            q_extended[512] = 0;
            
            for (int i=0; i<512; i=i+1) begin
                case (q_extended[i+2:i])
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
