module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'd0;
localparam SHIFT = 2'd1;
localparam RESET = 2'd2;

reg [1:0] state, next_state;
reg [1:0] counter;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (reset) begin
                next_state = RESET;
            end else begin
                next_state = IDLE;
            end
        end
        SHIFT: begin
            if (counter == 2'd3) begin
                next_state = IDLE;
            end else begin
                next_state = SHIFT;
            end
        end
        RESET: begin
            next_state = SHIFT;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    if (state == RESET) begin
        shift_ena <= 1'b1;
        counter <= 2'd0;
    end else if (state == SHIFT) begin
        shift_ena <= 1'b1;
        counter <= counter + 2'd1;
    end else begin
        shift_ena <= 1'b0;
        counter <= 2'd0;
    end
end

endmodule
