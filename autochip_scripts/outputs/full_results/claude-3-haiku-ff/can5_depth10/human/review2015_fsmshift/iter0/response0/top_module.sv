module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'd0;
localparam SHIFT = 2'd1;
localparam DONE = 2'd2;

reg [1:0] state, next_state;
reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counter <= 2'd0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        counter <= counter + 2'd1;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            shift_ena = 1'b1;
            if (counter == 2'd3) begin
                next_state = DONE;
            end
            else begin
                next_state = IDLE;
            end
        end
        DONE: begin
            shift_ena = 1'b0;
            next_state = DONE;
        end
        default: begin
            shift_ena = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
