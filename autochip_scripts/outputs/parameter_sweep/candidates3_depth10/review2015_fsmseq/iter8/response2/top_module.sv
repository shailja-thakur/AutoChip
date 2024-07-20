module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
reg [3:0] next_state;

parameter S0 = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        start_shifting <= 0;
    end else begin
        state <= next_state;
    end
end

always @(state, data) begin
    case (state)
        S0: begin
            if (data == 1'b1)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (data == 1'b1)
                next_state = S2;
            else
                next_state = S0;
        end
        S2: begin
            if (data == 1'b0)
                next_state = S3;
            else
                next_state = S0;
        end
        S3: begin
            if (data == 1'b1)
                next_state = S0;
            else
                next_state = S3;
        end
        default: begin
            next_state = S0;
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset)
        start_shifting <= 0;
    else if (state == S3)
        start_shifting <= 1;
    else
        start_shifting <= start_shifting;
end

endmodule
