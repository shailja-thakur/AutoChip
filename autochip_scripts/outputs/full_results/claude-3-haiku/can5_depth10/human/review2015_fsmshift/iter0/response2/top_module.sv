module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

// State variables
reg [1:0] state;
parameter IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b11;

// Counter for shift cycles
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 2'b00;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                count <= 2'b00;
                state <= SHIFT;
            end
            SHIFT: begin
                if (count == 2'b11) begin
                    shift_ena <= 1'b0;
                    state <= DONE;
                end
                else begin
                    shift_ena <= 1'b1;
                    count <= count + 1'b1;
                end
            end
            DONE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
