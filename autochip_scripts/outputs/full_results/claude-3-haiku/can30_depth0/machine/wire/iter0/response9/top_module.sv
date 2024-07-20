module top_module(
    input clock,
    input reset,
    output data_out,
    output valid_out
);

    reg [1:0] state;
    reg [7:0] counter;

    parameter IDLE = 2'b00,
              WAIT = 2'b01,
              PROCESS = 2'b10,
              DONE = 2'b11;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 1'b0;
            valid_out <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 1'b0;
                    if (counter == 8'd10) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 1'b1;
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
