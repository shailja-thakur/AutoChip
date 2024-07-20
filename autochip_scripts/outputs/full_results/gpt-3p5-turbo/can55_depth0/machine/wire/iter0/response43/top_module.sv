module top_module(
    input wire clk,
    input wire reset,
    output reg out,
    output reg valid
);

reg [1:0] state;
reg [7:0] counter;
reg [7:0] data_out;

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_out <= 0;
        valid <= 0;
    end else begin
        case (state)
            IDLE: begin
                counter <= 0;
                data_out <= 0;
                valid <= 0;
                if (in) begin
                    state <= WAIT;
                end
            end

            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                valid <= 0;
                if (counter == 10) begin
                    state <= PROCESS;
                end
            end

            PROCESS: begin
                data_out <= in;
                valid <= 0;
                state <= DONE;
            end

            DONE: begin
                valid <= 1;
                state <= IDLE;
            end
        endcase
    end
end

assign out = data_out;

endmodule
