module top_module (
    input clk,
    input reset,
    output reg [31:0] data_out,
    output reg valid_out
);

reg [1:0] state;
reg [31:0] counter;

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_out <= 0;
        valid_out <= 0;
    end else begin
        case (state)
            IDLE: begin
                counter <= 0;
                data_out <= 0;
                valid_out <= 0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 32'h00000064) begin // Wait for 100 cycles
                    state <= PROCESS;
                end else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                // Perform processing on the input data
                data_out <= data_out + 1;
                state <= DONE;
            end
            DONE: begin
                valid_out <= 1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
