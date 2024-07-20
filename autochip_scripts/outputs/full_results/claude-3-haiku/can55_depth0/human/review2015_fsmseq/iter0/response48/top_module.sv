module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] 
    S0 = 2'b00, 
    S1 = 2'b01, 
    S2 = 2'b10, 
    S3 = 2'b11;
    
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= S0;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            S0: begin
                if (data == 1'b1) begin
                    state <= S1;
                end
                else begin
                    state <= S0;
                end
            end
            S1: begin
                if (data == 1'b1) begin
                    state <= S2;
                end
                else begin
                    state <= S0;
                end
            end
            S2: begin
                if (data == 1'b0) begin
                    state <= S3;
                end
                else begin
                    state <= S0;
                end
            end
            S3: begin
                if (data == 1'b1) begin
                    state <= S0;
                    start_shifting <= 1'b1;
                end
                else begin
                    state <= S0;
                end
            end
            default: begin
                state <= S0;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
