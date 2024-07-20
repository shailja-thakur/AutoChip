module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [3:0] S0 = 4'b0000,
                 S1 = 4'b0001,
                 S2 = 4'b0010,
                 S3 = 4'b0011,
                 S4 = 4'b0100;

reg [3:0] state, next_state;

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
                next_state = S0;
            else
                next_state = S1;
            start_shifting = 1'b0;
        end
        S1: begin
            if (data == 1'b0)
                next_state = S2;
            else
                next_state = S1;
            start_shifting = 1'b0;
        end
        S2: begin
            if (data == 1'b0)
                next_state = S3;
            else
                next_state = S1;
            start_shifting = 1'b0;
        end
        S3: begin
            if (data == 1'b1)
                next_state = S4;
            else
                next_state = S0;
            start_shifting = 1'b0;
        end
        S4: begin
            next_state = S4;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = S0;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
