module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        shift_ena <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                count <= 4;
                next_state <= SHIFT;
            end
            SHIFT: begin
                if (count > 0) begin
                    count <= count - 1;
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                    next_state <= DONE;
                end
            end
            DONE: begin
                shift_ena <= 1'b0;
                next_state <= DONE;
            end
            default: begin
                state <= IDLE;
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
