module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam [1:0] 
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11;

// State register
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        start_shifting <= 0;
    end
    else begin
        case (state)
            S0: begin
                if (data == 1'b1)
                    state <= S1;
                else
                    state <= S0;
            end
            S1: begin
                if (data == 1'b1)
                    state <= S2;
                else
                    state <= S0;
            end
            S2: begin
                if (data == 1'b0)
                    state <= S3;
                else
                    state <= S0;
            end
            S3: begin
                if (data == 1'b1) begin
                    state <= S0;
                    start_shifting <= 1;
                end
                else begin
                    state <= S0;
                end
            end
            default: begin
                state <= S0;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
