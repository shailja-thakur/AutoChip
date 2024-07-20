module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'b00, SHIFT = 2'b01, RESET = 2'b10;
reg [1:0] state, next_state;
reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        counter <= 0;
    end
    else begin
        state <= next_state;
        counter <= counter + 1;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    case (state)
        IDLE: begin
            if (reset) begin
                next_state = RESET;
            end
            else begin
                next_state = IDLE;
            end
        end
        RESET: begin
            shift_ena = 1;
            if (counter == 2'd3) begin
                next_state = IDLE;
                counter = 0;
            end
            else begin
                next_state = RESET;
            end
        end
        default: begin
            // do nothing
        end
    endcase
end

endmodule
