module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counter <= 2'b00;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        counter <= (state == SHIFT) ? counter + 1 : 2'b00;
        shift_ena <= (state == SHIFT) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = SHIFT;
        end
        SHIFT: begin
            if (counter == 2'b11) begin
                next_state = DONE;
            end
            else begin
                next_state = SHIFT;
            end
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
