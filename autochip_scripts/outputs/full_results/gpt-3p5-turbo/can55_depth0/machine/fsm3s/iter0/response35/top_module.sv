module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
wire nextState_A, nextState_B, nextState_C, nextState_D;

assign nextState_A = (state == 2'b00) && (in == 1'b1);
assign nextState_B = (state == 2'b01) && (in == 1'b1);
assign nextState_C = (state == 2'b10) && (in == 1'b1);
assign nextState_D = (state == 2'b11) && (in == 1'b1);

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;
    else if (nextState_A)
        state <= 2'b01;
    else if (nextState_B)
        state <= 2'b01;
    else if (nextState_C)
        state <= 2'b10;
    else if (nextState_D)
        state <= 2'b11;
end

assign out = (state == 2'b11);

endmodule
