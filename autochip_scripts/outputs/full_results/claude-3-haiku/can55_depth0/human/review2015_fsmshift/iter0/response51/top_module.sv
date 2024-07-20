module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

parameter IDLE = 2'b00, ACTIVE = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 3'd0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        if (state == IDLE) begin
            shift_ena <= 1'b1;
            count <= 3'd4;
        end
        else if (state == ACTIVE) begin
            if (count > 0) begin
                count <= count - 1;
            end
            else begin
                shift_ena <= 1'b0;
            end
        end
        else begin
            shift_ena <= 1'b0;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (reset) begin
                next_state = IDLE;
            end
            else begin
                next_state = ACTIVE;
            end
        end
        ACTIVE: begin
            if (count == 0) begin
                next_state = DONE;
            end
            else begin
                next_state = ACTIVE;
            end
        end
        DONE: begin
            next_state = DONE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
