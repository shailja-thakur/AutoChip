module top_module(
    input clk,
    input reset,
    output data_out,
    output valid_out
);

    reg [1:0] state;
    reg [7:0] counter;

    parameter IDLE = 2'd0;
    parameter WAIT = 2'd1;
    parameter PROCESS = 2'd2;
    parameter DONE = 2'd3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'd0;
                    data_out <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 8'd1;
                    data_out <= 1'b0;
                    if (counter == 8'd100) begin
                        state <= PROCESS;
                    end else begin
                        state <= WAIT;
                    end
                end
                PROCESS: begin
                    data_out <= 1'b1; // Set the data output
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1'b1; // Assert the valid output
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
