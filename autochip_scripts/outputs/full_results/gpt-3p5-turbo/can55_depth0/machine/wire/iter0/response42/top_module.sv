module top_module(
    input wire clk,
    input wire reset,
    output reg out,
    output reg valid);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    // FSM states
    parameter IDLE = 0;
    parameter WAIT = 1;
    parameter PROCESS = 2;
    parameter DONE = 3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            out <= 0;
            valid <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 0;
                    out <= 0;
                    if (in) begin
                        state <= WAIT;
                    end
                end
                WAIT: begin
                    counter <= counter + 1;
                    out <= 0;
                    if (counter == 10) begin
                        state <= PROCESS;
                        counter <= 0;
                        data <= in;
                    end
                end
                PROCESS: begin
                    out <= data;
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
