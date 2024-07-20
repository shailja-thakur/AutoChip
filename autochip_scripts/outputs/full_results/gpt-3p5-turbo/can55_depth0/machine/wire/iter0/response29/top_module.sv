module top_module(
    input wire clk,
    input wire rst,
    output reg out,
    output reg valid
);

reg [1:0] state;
reg [3:0] counter;
reg [7:0] data;

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        counter <= 4'd0;
        data <= 8'd0;
        out <= 1'b0;
        valid <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                counter <= 4'd0;
                data <= 8'd0;
                out <= 1'b0;
                valid <= 1'b0;
                if (in) begin
                    state <= WAIT;
                end
            end
            WAIT: begin
                counter <= counter + 1;
                data <= 8'd0;
                out <= 1'b0;
                valid <= 1'b0;
                if (counter == 4'b1111) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data <= in;
                out <= data;
                valid <= 1'b1;
                state <= DONE;
            end
            done: begin
                out <= 1'b0;
                counter <= 4'd0;
                valid <= 1'b0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
