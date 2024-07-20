module top_module(
    input clk,
    input reset,
    output shift_ena
);

reg [3:0] counter;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter ENABLE = 2'b01;
parameter COUNT = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 4'b1111;
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (shift_ena) begin
                    state <= ENABLE;
                end
            end
            ENABLE: begin
                if (counter == 0) begin
                    state <= COUNT;
                    counter <= 4'b0000;
                end else begin
                    counter <= counter - 1;
                end
            end
            COUNT: begin
                counter <= 4'b0000;
                state <= IDLE;
            end
        endcase
    end
end

assign shift_ena = (state == ENABLE);

endmodule
