module top_module(
    input clk,
    input rst,
    output reg data_out,
    output reg valid
);

    reg [1:0] state;
    reg [7:0] counter;

    parameter IDLE = 0;
    parameter WAIT = 1;
    parameter PROCESS = 2;
    parameter DONE = 3;

    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid <= 0;
        end
        else
        begin
            case (state)
                IDLE:
                    begin
                        counter <= 0;
                        data_out <= 0;
                        valid <= 0;
                        if (in)
                            state <= WAIT;
                    end
                WAIT:
                    begin
                        counter <= counter + 1;
                        data_out <= 0;
                        valid <= 0;
                        if (counter >= 10) // Threshold value for counter
                            state <= PROCESS;
                    end
                PROCESS:
                    begin
                        data_out <= in;
                        valid <= 1;
                        state <= DONE;
                    end
                DONE:
                    begin
                        valid <= 1;
                        state <= IDLE;
                    end
            endcase
        end
    end

endmodule
