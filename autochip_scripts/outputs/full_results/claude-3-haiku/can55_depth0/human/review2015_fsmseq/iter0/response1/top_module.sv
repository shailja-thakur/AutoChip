module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        S0: next_state = (data == 1'b0) ? S1 : S0;
        S1: next_state = (data == 1'b1) ? S2 : S0;
        S2: next_state = (data == 1'b1) ? S3 : S0;
        S3: next_state = (data == 1'b1) ? S3 : S0;
        default: next_state = S0;
    endcase
end

// Output logic
always @(*) begin
    start_shifting = (state == S3);
end

// State register
always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

endmodule
