module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 4'b0000;
        start_shifting <= 0;
    end else begin
        case (state)
            4'b0000: begin  // S0
                if (data) 
                    state <= 4'b0001;
            end
            4'b0001: begin  // S1
                if (data) 
                    state <= 4'b0011;
                else 
                    state <= 4'b0000;
            end
            4'b0011: begin  // S2
                if (data) 
                    state <= 4'b0110;
                else 
                    state <= 4'b0000;
            end
            4'b0110: begin  // S3
                if (data) 
                    state <= 4'b1101;
                else 
                    state <= 4'b0000;
            end
            4'b1101: begin  // S4
                start_shifting <= 1;
                state <= 4'b0000;
            end
        endcase
    end
end

endmodule
