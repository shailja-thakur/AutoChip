module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'b00;
localparam COUNT = 2'b01;
localparam SHIFT = 2'b10;

reg [1:0] state;
reg [1:0] next_state;
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
                if (reset) begin
                    cycle_count <= 2'b00;
                    shift_ena <= 1'b1;
                end
                else begin
                    next_state <= COUNT;
                end
            end
            COUNT: begin
                shift_ena <= 1'b1;
                cycle_count <= cycle_count + 1'b1;
                if (cycle_count == 2'b11) begin
                    next_state <= SHIFT;
                end
                else begin
                    next_state <= COUNT;
                end
            end
            SHIFT: begin
                shift_ena <= 1'b0;
                next_state <= IDLE;
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
