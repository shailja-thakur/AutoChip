module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] IDLE = 2'd0,
                 SHIFT = 2'd1;

reg [1:0] state, next_state;
reg [1:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 2'b00;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        counter <= (state == SHIFT) ? counter + 1 : 2'b00;
        shift_ena <= (state == SHIFT && counter < 2'd3) ? 1'b1 : 1'b0;
    end
end

always @* begin
    case (state)
        IDLE: begin
            next_state = reset ? SHIFT : IDLE;
        end
        SHIFT: begin
            next_state = (counter == 2'd3) ? IDLE : SHIFT;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
