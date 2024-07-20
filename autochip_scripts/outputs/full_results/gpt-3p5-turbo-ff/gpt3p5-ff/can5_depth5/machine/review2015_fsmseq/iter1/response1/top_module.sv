module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;
reg [2:0] next_state;

initial begin
    state <= 3'b000;
    next_state <= 3'b000;
    start_shifting <= 1'b0;
end

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
        start_shifting <= (state == 3'b111) ? 1'b1 : 1'b0;
    end

    case(state)
        3'b000: if(data) next_state = 3'b001; else next_state = 3'b000;
        3'b001: if(data) next_state = 3'b011; else next_state = 3'b000;
        3'b011: if(data) next_state = 3'b011; else next_state = 3'b110;
        3'b110: if(data) next_state = 3'b111; else next_state = 3'b000;
        3'b111: next_state = 3'b111;
    endcase
end

endmodule
