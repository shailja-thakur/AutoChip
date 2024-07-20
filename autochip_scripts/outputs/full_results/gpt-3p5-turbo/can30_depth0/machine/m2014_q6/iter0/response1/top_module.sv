module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [3:0] state;
wire next_state_A, next_state_B, next_state_C, next_state_D, next_state_E, next_state_F;

assign next_state_A = (state == 4'b0000) && (w == 1'b1);
assign next_state_B = (state == 4'b0000) && (w == 1'b0);
assign next_state_C = (state == 4'b0001) && (w == 1'b1);
assign next_state_D = (state == 4'b0001) && (w == 1'b0);
assign next_state_E = (state == 4'b0010) && (w == 1'b1);
assign next_state_F = (state == 4'b0010) && (w == 1'b0);

always @(posedge clk) begin
    if (reset)
        state <= 4'b0000;
    else begin
        case (state)
            4'b0000: state <= next_state_B ? 4'b0010 : 4'b0000;
            4'b0001: state <= next_state_D ? 4'b1000 : 4'b0010;
            4'b0010: state <= next_state_E ? 4'b0100 : 4'b0010;
            4'b0100: state <= next_state_D ? 4'b0000 : 4'b0100;
            4'b1000: state <= next_state_F ? 4'b0100 : 4'b1000;
            default: state <= 4'b0000;
        endcase
    end
end

assign z = (state == 4'b0010 || state == 4'b1000) ? 1'b1 : 1'b0;

endmodule
