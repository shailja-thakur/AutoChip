module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

reg [1:0] state;
reg [7:0] counter;

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
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 8'd100) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                // Perform processing on the input data
                data_out <= 8'hAB;
                state <= DONE;
            end
            DONE: begin
                valid <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
