module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'b00,
          SHIFT = 2'b01,
          DONE  = 2'b11;

reg [1:0] state, next_state;
reg [1:0] cycle_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        cycle_count <= 2'b00;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                if (cycle_count == 2'b11) begin
                    next_state <= DONE;
                end
                else begin
                    cycle_count <= cycle_count + 1'b1;
                    next_state <= SHIFT;
                end
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                if (cycle_count == 2'b11) begin
                    next_state <= DONE;
                end
                else begin
                    cycle_count <= cycle_count + 1'b1;
                    next_state <= SHIFT;
                end
            end
            DONE: begin
                shift_ena <= 1'b0;
                next_state <= DONE;
            end
        endcase
    end
end

endmodule
