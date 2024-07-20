module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [2:0] S0 = 3'b000, 
                 S1 = 3'b001, 
                 S2 = 3'b010, 
                 S3 = 3'b011, 
                 S4 = 3'b100;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= S0;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == S4)
            start_shifting <= 1;
    end
end

always @(*) begin
    case (state)
        S0: next_state = (data == 1'b1) ? S1 : S0;
        S1: next_state = (data == 1'b0) ? S2 : S1;
        S2: next_state = (data == 1'b1) ? S3 : S2;
        S3: next_state = (data == 1'b1) ? S4 : S0;
        S4: next_state = S4;
        default: next_state = S0;
    endcase
end

endmodule
