module top_module(
    input clk,
    input reset,
    output reg [1:0] state,
    output reg shift_ena
);

always @(posedge clk) begin
    if (reset == 1'b1) begin
        state <= 2'b00;
        shift_ena <= 1'b1;
    end else begin
        case (state)
            2'b00: begin
                state <= 2'b01;
                shift_ena <= 1'b1;
            end
            2'b01: begin
                state <= 2'b10;
                shift_ena <= 1'b1;
            end
            2'b10: begin
                state <= 2'b11;
                shift_ena <= 1'b1;
            end
            2'b11: begin
                state <= 2'b00;
                shift_ena <= 1'b1;
            end
            default: begin
                state <= 2'b00;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
