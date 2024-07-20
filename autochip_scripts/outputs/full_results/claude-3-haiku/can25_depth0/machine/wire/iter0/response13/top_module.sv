module top_module(
    input clk,
    input reset,
    output data_out,
    output valid_out
);

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;

    // States
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
                    if (counter == 8'd255) begin
                        state <= PROCESS;
                    end else begin
                        state <= WAIT;
                    end
                end
                PROCESS: begin
                    data_out <= /*processed data*/;
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
