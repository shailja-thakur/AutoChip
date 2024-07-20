module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] STATE_IDLE = 2'b00, 
                 STATE_SHIFT = 2'b01,
                 STATE_DONE = 2'b10;

reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        count <= 2'b00;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_IDLE: begin
                shift_ena <= 1'b1;
                count <= 2'b00;
            end
            STATE_SHIFT: begin
                if (count == 2'b11) begin
                    shift_ena <= 1'b0;
                    next_state <= STATE_DONE;
                end
                else begin
                    shift_ena <= 1'b1;
                    count <= count + 1'b1;
                end
            end
            STATE_DONE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

always @* begin
    case (state)
        STATE_IDLE: begin
            next_state = STATE_SHIFT;
        end
        STATE_SHIFT: begin
            next_state = STATE_SHIFT;
        end
        STATE_DONE: begin
            next_state = STATE_IDLE;
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
