module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] next_state;

parameter IDLE = 2'b00;
parameter CHECKING_1 = 2'b01;
parameter CHECKING_2 = 2'b10;
parameter SETTING_Z = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(state or w) begin
    case (state)
        IDLE: begin
            if (s) begin
                next_state = CHECKING_1;
            end else begin
                next_state = IDLE;
            end
        end
        CHECKING_1: begin
            if (w) begin
                next_state = CHECKING_2;
            end else begin
                next_state = IDLE;
            end
        end
        CHECKING_2: begin
            if (w) begin
                next_state = SETTING_Z;
            end else begin
                next_state = IDLE;
            end
        end
        SETTING_Z: begin
            next_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin
    if (state == SETTING_Z) begin
        z <= 1;
    end else begin
        z <= 0;
    end
end

endmodule
