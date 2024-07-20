module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg current_state;
parameter IDLE = 1'b0, ACTIVE = 1'b1;

always @(posedge clk) begin
    case ({a, b})
        2'b00: begin
            current_state <= IDLE;
            q <= 1'b0;
        end
        2'b01: begin
            current_state <= ACTIVE;
            q <= 1'b1;
        end
        2'b10: begin
            current_state <= IDLE;
            q <= 1'b1;
        end
        2'b11: begin
            current_state <= ACTIVE;
            q <= 1'b0;
        end
    endcase

    state <= current_state;
end

endmodule
