module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
reg [1:0] next_state;

localparam IDLE = 2'b00;
localparam SHIFT = 2'b01;
localparam DONE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (reset) begin
                next_state = SHIFT;
                shift_ena = 1'b1;
            end
            else begin
                next_state = IDLE;
                shift_ena = 1'b0;
            end
        end
        SHIFT: begin
            next_state = DONE;
            shift_ena = 1'b1;
        end
        DONE: begin
            next_state = IDLE;
            shift_ena = 1'b0;
        end
        default: begin
            next_state = IDLE;
            shift_ena = 1'b0;
        end
    endcase
end

endmodule
