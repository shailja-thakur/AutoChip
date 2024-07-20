module top_module(
    input clk,
    input reset,
    output data_out,
    output valid_out
);

reg [1:0] state;
reg [3:0] counter;

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

parameter THRESHOLD = 4'b1000; // Counter threshold

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        state <= IDLE;
        counter <= 4'b0;
        data_out <= 1'b0;
        valid_out <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                counter <= 4'b0;
                data_out <= 1'b0;
                valid_out <= 1'b0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1'b1;
                data_out <= 1'b0;
                if (counter == THRESHOLD) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                data_out <= 1'b1; // Set the data output
                state <= DONE;
            end
            DONE: begin
                valid_out <= 1'b1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
