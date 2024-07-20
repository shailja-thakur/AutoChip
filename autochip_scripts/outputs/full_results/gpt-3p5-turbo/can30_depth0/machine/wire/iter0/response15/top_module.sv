module top_module(
    input clk,
    input reset,
    output reg data_output,
    output reg valid_output
    );

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;

    // FSM states
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_output <= 1'b0;
            valid_output <= 1'b0;
        end else begin
            case(state)
                IDLE: begin
                    counter <= 8'b0;
                    data_output <= 1'b0;
                    valid_output <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_output <= 1'b0;
                    valid_output <= 1'b0;
                    if (counter == 8'hFF) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_output <= in;
                    valid_output <= 1'b1;
                    state <= DONE;
                end
                DONE: begin
                    valid_output <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
