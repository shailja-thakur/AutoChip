module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S0: begin
            if (data == 1'b0)
                next_state = S1;
            else
                next_state = S0;
            start_shifting = 1'b0;
        end
        S1: begin
            if (data == 1'b1)
                next_state = S2;
            else
                next_state = S0;
            start_shifting = 1'b0;
        end
        S2: begin
            if (data == 1'b0)
                next_state = S3;
            else
                next_state = S0;
            start_shifting = 1'b0;
        end
        S3: begin
            if (data == 1'b1)
                next_state = S0;
            else
                next_state = S0;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = S0;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
