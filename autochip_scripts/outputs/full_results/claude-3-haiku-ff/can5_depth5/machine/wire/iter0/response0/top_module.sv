module top_module(
    input clock,
    input reset,
    output data_out,
    output valid_out
);

    reg state;
    reg [7:0] counter;

    localparam IDLE = 0;
    localparam WAIT = 1;
    localparam PROCESS = 2;
    localparam DONE = 3;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 0;
                    if (counter == 8'hFF) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 1; // set data_out to the processed data
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
