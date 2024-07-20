module top_module(
    input clk,
    input reset,
    output reg data_out,
    output reg valid_out
);

reg [1:0] state;
reg [3:0] counter;

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_out <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 4'b1010) begin // counter reaches threshold
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data_out <= 1; // set data_out to the processed data
                state <= DONE;
            end
            DONE: begin
                valid_out <= 1; // assert valid_out
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
