module top_module(
    input clock,
    input reset,
    output data_output,
    output valid_output);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_output;
    reg valid_output;

    // FSM states
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_output <= 8'b0;
            valid_output <= 0;
        end else begin
            case (state)
                IDLE:
                    begin
                        counter <= 8'b0;
                        data_output <= 8'b0;
                        valid_output <= 0;
                        if (in) begin
                            state <= WAIT;
                        end
                    end
                WAIT:
                    begin
                        counter <= counter + 1;
                        data_output <= 8'b0;
                        valid_output <= 0;
                        if (counter == 8'hFF) begin
                            state <= PROCESS;
                        end
                    end
                PROCESS:
                    begin
                        data_output <= in;
                        valid_output <= 1;
                        state <= DONE;
                    end
                DONE:
                    begin
                        valid_output <= 1;
                        state <= IDLE;
                    end
                default:
                    state <= IDLE;
            endcase
        end
    end
endmodule
