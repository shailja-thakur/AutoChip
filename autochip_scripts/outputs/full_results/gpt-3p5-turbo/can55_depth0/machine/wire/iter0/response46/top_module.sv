module top_module(
    input wire clk,
    input wire rst,
    output reg out,
    output reg valid
);

reg [1:0] state;
reg [7:0] counter;
reg [7:0] data_output;

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        counter <= 8'd0;
        data_output <= 8'd0;
    end else begin
        case (state)
            IDLE: begin
                counter <= 8'd0;
                data_output <= 8'd0;
                if (in) begin
                    state <= WAIT;
                end
            end
            WAIT: begin
                counter <= counter + 1;
                data_output <= 8'd0;
                if (counter == 8'd10) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data_output <= in;
                state <= DONE;
            end
            DONE: begin
                valid <= 1'b1;
                state <= IDLE;
            end
        endcase
    end
end

assign out = data_output;

endmodule
