module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire [2:0] next_state;

always @(posedge clk, posedge reset)
begin
    if (reset)
        state <= 3'd0;
    else
        state <= next_state;
end

assign next_state = (state == 3'd0) ? (w ? 3'd0 : 3'd1) :
                   (state == 3'd1) ? (w ? 3'd3 : 3'd2) :
                   (state == 3'd2) ? (w ? 3'd1 : 3'd4) :
                   (state == 3'd3) ? (w ? 3'd4 : 3'd3) :
                   (state == 3'd4) ? (w ? 3'd4 : 3'd2) :
                   (state == 3'd5) ? (w ? 3'd5 : 3'd4) :
                   (state == 3'd6) ? (w ? 3'd2 : 3'd3) :
                   (state == 3'd7) ? (w ? 3'd3 : 3'd2) : 3'd0;

always @(state, w)
begin
    case(state)
        3'd0: z = 1'b0;
        3'd1: z = 1'b1;
        3'd2: z = 1'b0;
        3'd3: z = 1'b1;
        3'd4: z = 1'b0;
        3'd5: z = 1'b1;
        3'd6: z = 1'b0;
        3'd7: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
